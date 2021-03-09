class Card
    attr_accessor :rank, :suit
    
    def initialize(rank:, suit:)
        @rank = rank
        @suit = suit
    end

    # Creates a card from short name of card.
    # For example, "kd" is short for "King of Diamonds"
    def self.from_str(short)
        arr = short.downcase.split(//)
        rank = Rank.from_str(arr.first())
        suit = Suit.from_str(arr.second())
        Card.new(rank: rank, suit: suit)
    end

    def self.of(rank, suit)
        Card.new(rank: Rank.of(rank), suit: Suit.of(suit))
    end

    def ==(other)
        return (self.rank == other.rank && self.suit.name == other.suit.name)
    end

    def eql?(other)
        self == other
    end

    def hash
        [rank, suit.name].hash
    end

    def to_s
        "#{rank.name} of #{suit.name}"
    end
end
# key = "#{r.name}_#{s.name}".upcase.to_sym