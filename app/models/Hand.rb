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

    def to_s
        metahand.name
    end

    private

    def cards_str
        # ap tb.rounds.values.first.hands.map{|k,v| "#{k.name} | #{v.metahand.name}" }
        cards.map{|card| card.to_s}.join("\n\t")
    end


end