class Card
    include Comparable

    # Todo: could make keys and suits symbols
    RANKS = ((2..10) + %w(J Q K A)).zip(0..12).to_h
    SUITS = %w(Hearts Diamonds Clubs Spades)

    attr_reader :rank, :suit

    def self.ranks
        RANKS
    end

    def self.suits
        SUITS
    end

    def initialize(rank:, suit:)
        raise "Invalid rank" unless RANKS.include?(rank)
        raise "Invalid suit" unless SUITS.include?(suit)
        @rank = rank
        @suit = suit
    end

    # Creates a card from short name of card.
    # For example, "kd" is short for "King of Diamonds"
    def self.from_str(short)
        r, s = short.upcase.split(//)
        r_num = r.to_i
        rank = if r_num != 0 then r_num else r end

        suit = SUITS.find{|suit| suit.initial == s}
        Card.new(rank: rank, suit: suit)
    end

    def <=>(card)
        RANKS[@rank] <=> RANKS[card.rank]
    end

    def suited_with?(card)
        suit == card.suit
    end

    def ==(other)
        self.rank == other.rank && self.suit == other.suit
    end

    def eql?(other)
        self == other
    end

    def hash
        [rank, suit.name].hash
    end

    def to_s()
        "#{@rank} of #{@suit}"
    end
end