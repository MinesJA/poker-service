class Deck
    attr_reader :cards

    def initialize()
        @cards = generate_cards()
    end

    def deal()
        if(self.cards.size > 0)
            self.cards.shift()
        else
            raise "Deck is empty. Cannot deal more than 52 cards."
        end
    end

    def contains(card)
        self.cards.include?(card)
    end

    def size
        self.cards.size
    end

    def ==(other)
        self.cards == other.cards
    end

    def eql?(other)
        self == other
    end

    def hash
        cards.hash
    end

    private

    def generate_cards()
        Suit::ALL.flat_map{ |s|
            Rank::ALL.map { |r| Card.new(r, s) }
        }.shuffle
    end

end