require_relative "../utils/array"

module IdentificationService
    
    # Should return Hand consisting of MetaHand and cards 
    # which constitue the actual MetaHand
    # 
    # Should pick the best possible hand, including taking into account
    # rank scores when you have two of the same hands.
    # 
    # royal_flush:  10,
    # straight_flush:  9,
    # four_kind:  8,
    # full_house:  7,
    # flush:  6,
    # straight:  5,
    # three_kind:  4,
    # two_pair:  3,
    # pair:  2,
    # high_card:  1
    # 
    # EXAMPLE
    # ==============
    # [Ace Spades, Ace Diamonds, Ace Clubs] > [Two Spades, Two Diamonds, Two Clubs]
    def identify(cards)
        [flush_straight_hands(cards), match_hands(cards), high_card(cards)].compact.max
    end
    
    private
    
    # Identifies hands that are rank match based
    # Pair, Two Pair, Three Kind, Full House, Four Kind
    def match_hands(cards)
        by_freq = cards.group_by_frequency(&:rank)
        
        if by_freq.key?(4)
            # There can only be one set of 4, so on need to check for another
            kicker = by_freq.values_at(1,2,3).flatten.compact.max
            return Hand.new(type: :four_kind, cards: by_freq[4], kicker: [kicker])
        elsif by_freq.key?(3)
            threes = by_freq[3].max(3)
            if by_freq.key?(2)
                twos = by_freq[2].max(2)
                return Hand.new(type: :full_house, cards: threes + twos)
            else
                kicker = by_freq.values_at(1,2,3).flatten.compact
                            .filter{|c| !threes.include?(c)}
                            .max
                return Hand.new(type: :three_kind, cards: threes, kicker: [kicker])
            end
        elsif by_freq.key?(2)
            twos = by_freq[2].max(4)
            kicker = by_freq.values_at(1,2).flatten.compact
                            .filter{|c| !twos.include?(c)}
                            .max
            if twos.size == 4
                return Hand.new(type: :two_pair, cards: twos, kicker: [kicker])
            else
                return Hand.new(type: :pair, cards: twos, kicker: [kicker])
            end
        end
    end

    # Covers Flush based hands and straight
    # Royal Flush, Straight Flush, Flush, Straight
    def flush_straight_hands(cards)

        # Because we only have 7 cards, can only have
        # 5, 6, or 7 cards of same suit at any given time
        suit_5 = cards.group_by_frequency(&:suit)
                    .values_at(5,6,7)
                    .flatten.compact
        
        if suit_5
            # Will only be able to find one group at most
            seq_5 = suit_5.sequences.detect{|seq| seq.size >= 5}.sort.max(5)

            # TODO: Don't love this string checking....
            if seq_5 && seq_5.first.rank == :"10"
                return Hand.new(type: :royal_flush, cards: seq_5)
            elsif seq_t
                return Hand.new(type: :straight_flush, cards: seq_5)
            else
                return Hand.new(type: :flush, cards: suit_5.max(5))
            end
        else 
            # Again, will only be able to find one group at most
            straight_cards = cards.sequences.detect{|seq| seq.size >= 5}.max(5)
            if straight_cards
                return Hand.new(type: :straight, cards: straight_cards)
            end
        end
    end

    def high_card(cards)
        return Hand.new(metahand: :high_card, cards: [cards.max], kicker: cards.max(5))
    end
end