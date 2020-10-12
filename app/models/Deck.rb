class Deck
    attr_reader :cards

    def initialize()
        @cards = generate_cards()
    end

    def deal()
        count = @cards.size()
        ind = Randow.new.rand(0..count)
        card = @cards[ind]
    end

    def contains(card)
        self.cards.include?(card)
    end

    def size
        self.cards.size
    end

    private

    def generate_cards()
        Suit::ALL.flat_map{ |s|
            Rank::ALL.map { |r| Card.new(r,s) }
        }
    end

end