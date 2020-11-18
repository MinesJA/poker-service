require_relative "../utils/array"

module IdentificationService
    
    
    # 1. Royal Flush
        # 5 cards
        # Rank Seq
        # Suit Match
    # 2. Straight Flush
        # 5 cards
        # Rank Seq
        # Suit Match
    # 3. Four Kind
        # 4 cards
        # Rank Match
    # 4. Full House
        # 5 cards
        # Rank Match
    # 5. Flush
        # 5 cards
        # Suit Match
    # 6. Straight
        # 5 cards
        # Rank Seq 
    # 7. Three Kind
        # 3 cards
        # Rank Match 
    # 8. Two Pair
        # 4 cards
        # Rank Match
    # 9. Pair
        # 2 cards
        # Rank Match
    # 10. High Card
        # 1 card
    
    # Min 5 Cards
    # 1. Royal Flush
    # 2. Straight Flush
    # 4. Full House
    # 5. Flush
    # 6. Straight
    
    # Min 4 Cards
    # 3. Four Kind
    # 8. Two Pair
    
    # Min 3 Cards
    # 7. Three Kind
    
    # Min 2 Cards
    # 9. Pair
    
    # Should return Hand consisting of MetaHand and cards 
    # which constitue the actual MetaHand
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

                            # Technically could return [[],[]]
                            # .sort_by{|card| card.rank.score }[0..4]

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