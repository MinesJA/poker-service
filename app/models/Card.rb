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

    def marshal_dump
        # TODO: implment strategy that produces:
        # <Card rank=King suit=Diamonds> => "KD"
        # 
        # {}.tap do |result|
        #   result[:age]      = age
        #   result[:fullname] = fullname if fullname.size <= 64
        #   result[:roles]    = roles unless roles.include? :admin
        # end
    end
    
    def marshal_load(serialized_user)
        # TODO: implment strategy that takes:
        # "KD" => <Card rank=King suit=Diamonds>
        # or "King Diamonds" => <Card rank=King suit=Diamonds>
        # 
        # self.age      = serialized_user[:age]
        # self.fullname = serialized_user[:fullname]
        # self.roles    = serialized_user[:roles] || []
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
end