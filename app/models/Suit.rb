module Suit
    suit = Struct.new(:name)
  
    CLUBS = suit.new("clubs")
    DIAMONDS = suit.new("diamonds")
    SPADES = suit.new("spades")
    HEARTS = suit.new("hearts")
  
    ALL = [CLUBS, DIAMONDS, SPADES, HEARTS]
end