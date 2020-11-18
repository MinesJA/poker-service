module MetaHand
    hand = Struct.new(:name, :description, :score)

    ROYAL_FLUSH = hand.new("Royal flush", "A, K, Q, J, 10, all the same suit.", 10)
    STRAIGHT_FLUSH = hand.new("Straight flush", "Five cards in a sequence, all in the same suit.", 9)
    FOUR_KIND = hand.new("Four of a kind", "All four cards of the same rank.", 8)
    FULL_HOUSE = hand.new("Full house", "Three of a kind with a pair.", 7)
    FLUSH = hand.new("Flush", "Any five cards of the same suit, but not in a sequence.", 6)
    STRAIGHT = hand.new("Straight", "Five cards in a sequence, but not of the same suit.", 5)
    THREE_KIND = hand.new("Three of a kind", "Three cards of the same rank.", 4)
    TWO_PAIR = hand.new("Two pair", "Two different pairs.", 3)
    PAIR = hand.new("Pair", "Two cards of the same rank.", 2)
    HIGH_CARD = hand.new("High Card", "When you haven't made any of the hands above, the highest card plays.", 1)

    ALL = [
        ROYAL_FLUSH, STRAIGHT_FLUSH, FOUR_KIND, FULL_HOUSE, FLUSH, STRAIGHT, THREE_KIND, TWO_PAIR, PAIR, HIGH_CARD
    ]
end