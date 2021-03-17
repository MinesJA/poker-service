require_relative "../utils/string" #TODO: Should not be loading like this...

class Card
    include Comparable

    # Todo: could make keys and suits symbols
    RANKS = ((2..10).to_a + %w(J Q K A)).zip(0..12).to_h
    SUITS = %w(Hearts Diamonds Clubs Spades)

    attr_reader :rank, :suit

    def self.ranks
        RANKS.keys
    end

    def self.suits
        SUITS
    end

    def initialize(rank, suit)
        raise ArgumentError.new("Invalid rank") unless RANKS.include?(rank)
        raise ArgumentError.new("Invalid suit") unless SUITS.include?(suit)
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
        Card.new(rank, suit)
    end

    def _dump(level)
        rank.to_s.concat(suit.initial)
    end
    
    def self._load(serialized_card)
        Card.from_str(serialized_card)
    end

    def score()
        RANKS[@rank]
    end

    def <=>(card)
        self.score <=> card.score
    end

    def ==(other)
        self.rank == other.rank && self.suit == other.suit
    end

    def eql?(other)
        self == other
    end

    def hash
        [rank, suit].hash
    end

    def to_s()
        "#{@rank} of #{@suit}"
    end

    def as_json(options)
        rank.to_s + suit.initial
    end
end