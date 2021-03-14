require_relative "../utils/array" #TODO: Should not be loading like this...

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
    def initialize(type:, cards:, kickers: [])
        # TODO: kickers prob needs to be {hole: [], community: []} with cards in order of deal 
        # (so last index of community should be last card dealth)
        raise "Invalid type" unless TYPES.include?(type)
        raise "Cards cannot be empty" unless cards.any?
        @type = type
        # TODO: Should cards be set?
        @cards = cards
        @kickers = kickers
    end

    def score()
        TYPES[@type]
    end

    def <=>(other)
        comp = self.score() <=> other.score()

        if comp == 0
            case @type
            when :high_card
                #  Highest card then
                #  Compare up to 4 kickers
                c = self.cards.first <=> other.cards.first
                if c == 0
                    return self.kickers.max(4).compare_sorted(other.kickers.max(4))
                end
                return c
            when :pair
                # Highest pair then
                # Compare up to 3 kickers
                c = self.cards.first <=> other.cards.first
                if c == 0
                    return self.kickers.max(3).compare_sorted(other.kickers.max(3))
                end
                return c
            when :two_pair 
                # Highest pair then
                # next pair
                # Compare 1 kicker
                c = self.cards.compare_sorted(other.cards)
                if c == 0
                    return self.kickers.max <=> other.kickers.max
                end
                return c
            when :three_kind
                # Strength of 3 of a kind
                # Compare up to 2 kickers
                c = self.cards.first <=> other.cards.first
                if c == 0
                    return self.kickers.max(2).compare_sorted(other.kickers.max(2))
                end
                return c

            when :straight 
                # Strongest single card 
                return self.cards.max <=> other.cards.max

            when :flush 
                # Compare all cards one by one sorted
                return self.cards.compare_sorted(other.cards)

            when :full_house 
                # Strength of 3 of a kind
                # Strengtho of the pair

                x = self.cards.group_by_frequency(&:rank)
                y = other.cards.group_by_frequency(&:rank)
                c = x[3].first <=> y[3].first

                if (fh == 0)
                    return x[2].first <=> y[2].first
                end
                return c

            when :four_kind 
                # Strength of 4 of a kind
                # Compare 1 kicker
                c = self.cards.first <=> other.cards.first
                if c == 0
                    return self.kickers.max(1).compare_sorted(other.kickers.max(1))
                end
                return c
            when :straight_flush 
                return self.cards.max <=> hand.cards.max
            when :royal_flush
                # No tie breaker, always a tie
                return 0
            end    
        end

        return comp
    end

    def ==(other)
        return self.type == other.type && 
            self.cards.difference(other.cards.difference).empty? &&
            self.kickers.difference(other.kickers.difference).empty?
    end

    def eql?(other)
        self == other
    end

    def hash
        [self.type, self.cards, self.kickers].hash
    end

    def to_s
        # TODO Dry this
        if (kickers)
            "#{self.type} with #{cards_str} and #{kickers_str} kicker"
        else
            "#{self.type} with #{cards_str}"
        end
    end

    private

    # TODO: Dry this
    def cards_str()
        # ap tb.rounds.values.first.hands.map{|k,v| "#{k.name} | #{v.metahand.name}" }
        cards.map{|card| card.to_s}.join("\n\t")
    end
    
    # TODO: Dry this
    def kickers_str()
        # ap tb.rounds.values.first.hands.map{|k,v| "#{k.name} | #{v.metahand.name}" }
        kickers.map{|card| card.to_s}.join("\n\t")
    end

end