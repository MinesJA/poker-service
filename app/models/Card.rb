class Card
    attr_accessor :rank, :suit
    
    def initialize(rank, suit)
        @rank = rank
        @suit = suit
    end

    def ==(other)
        return (self.rank.name == other.rank.name && self.suit.name == other.suit.name)
    end

    def eql?(other)
        self == other
    end

    def hash
        [rank.name, suit.name].hash
    end
end