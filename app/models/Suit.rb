module Suit
    suit = Struct.new(:name, :short)
  
    CLUBS = suit.new("clubs", "c")
    DIAMONDS = suit.new("diamonds", "d")
    SPADES = suit.new("spades", "s")
    HEARTS = suit.new("hearts", "h")
  
    ALL = [CLUBS, DIAMONDS, SPADES, HEARTS]

    def from_str(short:)
        ALL.find{|suit| suit.short == short}
    end
end