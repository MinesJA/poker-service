class Hand
    include Comparable

    TYPES = {
        royal_flush:  10,
        straight_flush:  9,
        four_kind:  8,
        full_house:  7,
        flush:  6,
        straight:  5,
        three_kind:  4,
        two_pair:  3,
        pair:  2,
        high_card:  1
    }

    # TYPES = %i(
    #     high_card 
    #     pair 
    #     two_pair 
    #     three_kind 
    #     straight 
    #     flush 
    #     full_house 
    #     four_kind 
    #     straight_flush 
    #     royal_flush).zip(0..9).to_h

    attr_reader :type, :cards, :kicker

    # Note that kicker is an array because
    # in the case that two players have matching
    # high cards as the winning hands, each players
    # 5 best cards, including community cards,
    # are used as kickers (discard worst 2 cards for each).
    def initialize(type:, cards:, kicker: [])  
        raise "Invalid type" unless TYPES.include?(type)
        @type = type
        @cards = cards
        @kicker = kicker
    end

    def self.types
        TYPES
    end

    def <=>(hand)
        TYPES[@type] <=> TYPES[hand.type]
    end

    def ==(other)
        return (self.type == other.type && 
                self.cards == other.cards && 
                self.kicker == other.kicker)
    end

    def eql?(other)
        self == other
    end

    def hash
        [self.type, self.cards, self.kicker].hash
    end

    def to_s
        # Todo refactor, could be shorter
        if (kicker)
            "#{self.type} with #{cards_str} and #{self.kicker} kicker"
        else
            "#{self.type} with #{cards_str}"
        end
    end

    private

    def cards_str
        # ap tb.rounds.values.first.hands.map{|k,v| "#{k.name} | #{v.metahand.name}" }
        cards.map{|card| card.to_s}.join("\n\t")
    end

end