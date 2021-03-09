class MetaHand < Enum
    meta_attr :formatted, :description, :score

    enum_attr :ROYAL_FLUSH, "Royal flush", "A, K, Q, J, 10, all the same suit.", 10
    enum_attr :STRAIGHT_FLUSH, "Straight flush", "Five cards in a sequence, all in the same suit.", 9
    enum_attr :FOUR_KIND, "Four of a kind", "All four cards of the same rank.", 8
    enum_attr :FULL_HOUSE, "Full house", "Three of a kind with a pair.", 7
    enum_attr :FLUSH, "Flush", "Any five cards of the same suit, but not in a sequence.", 6
    enum_attr :STRAIGHT, "Straight", "Five cards in a sequence, but not of the same suit.", 5
    enum_attr :THREE_KIND, "Three of a kind", "Three cards of the same rank.", 4
    enum_attr :TWO_PAIR, "Two pair", "Two different pairs.", 3
    enum_attr :PAIR, "Pair", "Two cards of the same rank.", 2
    enum_attr :HIGH_CARD, "High Card", "When you haven't made any of the hands above, the highest card plays.", 1
    
end