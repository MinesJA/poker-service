require_relative "../utils/array"

module IdentificationService
    
    # Should return Hand consisting of MetaHand and cards 
    # which constitue the actual MetaHand
    # 
    # Should pick the best possible hand, including taking into account
    # rank scores when you have two of the same hands.
    # 
    # EXAMPLE
    # ==============
    # [Ace Spades, Ace Diamonds, Ace Clubs] > [Two Spades, Two Diamonds, Two Clubs]
    def identify(cards)

        # Hands covered (by score) 1, 2, 5
        flush_based = flush_hands(cards)

        # Hands covered (by score) 3, 4, 7, 8, 9
        match_based = match_hands(cards)
        
        # Hands covered (by score) 6
        straight_based = straight_hands(cards)

        winning_hand = [flush_based, match_based, straight_based].compact.max_by{|hand| hand.metahand.score}

        return winning_hand.nil? ? Hand.new(metahand: MetaHand::HIGH_CARD, cards: cards.max_by{|card| card.rank.score}) : winning_hand
    end
    
    private
    
    # Identifies hands that are rank match based
    # Pair, Two Pair, Three Kind, Full House, Four Kind
    def match_hands(cards)
        by_freq = cards.group_by_frequency(&:rank)
        
        if by_freq.key?(4)
            # This assumes max 7 cards so won't have more than 4 of a kind
            return Hand.new(metahand: MetaHand::FOUR_KIND, cards: by_freq[4])
        elsif by_freq.key?(3)
            threes = by_freq[3].max_by(3){|card| card.rank.score}
            if by_freq.key?(2)
                twos = by_freq[2].max_by(2){|card| card.rank.score}
                return Hand.new(metahand: MetaHand::FULL_HOUSE, cards: threes + twos)
            else
                return Hand.new(metahand: MetaHand::THREE_KIND, cards: threes)
            end
        elsif by_freq.key?(2)
            twos = by_freq[2].max_by(4){|card| card.rank.score}
            if twos.size == 4
                return Hand.new(metahand: MetaHand::TWO_PAIR, cards: twos)
            else
                return Hand.new(metahand: MetaHand::PAIR, cards: twos)
            end
        end
    end

    # Covers all Flush based hands
    # Royal Flush, Straight Flush, Flush
    def flush_hands(cards)
        maybe_flush = cards.group_by{|card| card.suit }.values
                            .select{|grp| grp.size >= 5 }
                            .max_by{|grp| grp.reduce(0) {|sum, card| sum += card.rank.score}}

        if maybe_flush
            maybe_straight_flush = maybe_flush.sequences{|card| card.rank.score }
                                .select{|seq| seq.size >= 5}
                                .max_by{|grp| grp.reduce(0) {|sum, card| sum += card.rank.score}}
                                
            if maybe_straight_flush
                if maybe_straight_flush[0].rank == Rank::TEN
                    return Hand.new(metahand: MetaHand::ROYAL_FLUSH, cards: maybe_straight_flush)
                else
                    return Hand.new(metahand: MetaHand::STRAIGHT_FLUSH, cards: maybe_straight_flush.sort_by{|card| card.rank.score}.reverse[0..4])
                end
            else
                return Hand.new(metahand: MetaHand::FLUSH, cards: maybe_flush.sort_by{|card| card.rank.score}.reverse[0..4])
            end
        end
    end

    # Covers straight, not including Straight Flush
    # Straight
    def straight_hands(cards)
        straight_cards = cards.sequences{|card| card.rank.score }
                                .select{|seq| seq.size >= 5}
                                .max_by{|seq| seq.reduce(0) {|sum, card| sum += card.rank.score}}
                                
        if straight_cards
            return Hand.new(metahand: MetaHand::STRAIGHT, cards: straight_cards.sort_by{|card| card.rank.score })
        end
    end
end