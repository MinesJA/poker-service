class Hand
    include Comparable

    TYPES = %i(
        high_card 
        pair 
        two_pair 
        three_kind 
        straight 
        flush 
        full_house 
        four_kind 
        straight_flush 
        royal_flush).zip(1..10).to_h

    attr_reader :type, :cards, :kicker

    def self.types
        TYPES
    end

    # Note that kicker is an array because
    # in the case that two players have matching
    # high cards as the winning hands, each players
    # 5 best cards, including community cards,
    # are used as kickers.
    def initialize(type:, cards:, kicker: [])  
        raise "Invalid type" unless TYPES.include?(type)
        raise "Cards cannot be empty" unless cards.any?
        @type = type
        # TODO: Should cards be set?
        @cards = cards
        @kicker = kicker
    end

    def <=>(hand)
        TYPES[@type] <=> TYPES[hand.type]
    end

    def ==(other)
        return self.type == other.type && 
            self.cards.difference(other.cards.difference).empty? &&
            self.kicker.difference(other.kicker.difference).empty?
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