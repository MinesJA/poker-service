class Hand

    attr_reader :metahand, :cards

    def initialize(metahand:, cards:)
        @metahand = metahand
        @cards = cards
    end

    def ==(other)
        return (self.metahand == other.metahand && self.cards.frequency == other.cards.frequency)
    end

    def eql?(other)
        self == other
    end

    def hash
        [metahand, cards.frequency].hash
    end


end