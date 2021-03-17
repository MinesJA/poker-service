class Deck
    attr_reader :cards

    def initialize()
        @cards = generate_cards()
    end

    
    # Returns first card from the deck
    # by default or an array of first x
    # cards if given a count
    # 
    # NOTE: Does not shuffle
    # If a random card is requried, the deck
    # must be shuffle 
    # 
    # @param Integer count
    # @returns <Card> or <Array of Cards>
    def deal()
        card = self.cards.shift()
        raise "Cannot deal more than 52 cards." unless card
        return card
    end

    def deal_many(count)
        if self.cards.size >= count
            self.cards.shift(count)
        else 
            raise "Cannot deal more than 52 cards."
        end
    end

    # Pulls a specific card from a deck and 
    # returns it, and removes the card from 
    # the deck.
    def pull(card)
        card = self.cards.delete(card)
        raise "Cannot find card. May already have been dealt" unless card
        return card
    end

    # Pulls a specific card from a deck by 
    # the cards short name 
    # 
    # @param String short short name of card
    # @returns Card card object
    def pull_short(short)
        self.pull(Card.from_str(short))
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
        Card.suits.flat_map do |suit|
            Card.ranks.map do |rank, score|
              Card.new(rank, suit)
            end
        end.shuffle
    end
    
end