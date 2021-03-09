class Deck
    attr_reader :cards

    def initialize()
        @cards = generate_cards()
    end

    
    # Pulls first card from the deck
    # Should only be used as deal
    # if shuffle has already happened
    def deal()
        card = self.cards.shift()
        if (card)
            card
        else 
            raise "Deck is empty. Cannot deal more than 52 cards."
        end
    end

    # Pulls a specific card from a deck and 
    # returns it, and removes the card from 
    # the deck.
    def pull(card)
        self.cards.delete(card)
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

    def inspect
        "#<#{self.class}:#{self.object_id} @Cards=#{self.cards.size} cards>"
    end

    private

    def generate_cards()
        Suit.all.flat_map { |s|
            Rank.all.map { |r| Card.new(rank: r, suit: s)}
        }.shuffle
    end

end