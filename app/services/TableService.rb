class TableService

    attr_accessor :num_players, :player_holes, :community_cards, :burn_pile
    attr_reader :deck

    def initialize(num_players)
        @deck = Deck.new()
        @num_players = num_players
        @player_holes = {}
        @community_cards = []
        @burn_pile = []
    end

    def run_round()
        self.player_holes = deal()
        
        # burn
        self.burn_pile.push(deck.deal)

        # FLOP
        3.times { community_cards.push(deck.deal) }

        # burn
        self.burn_pile.push(deck.deal)

        # TURN
        community_cards.push(deck.deal)

        # burn
        self.burn_pile.push(deck.deal)

        # RIVER
        community_cards.push(deck.deal)
    end

    def deal()
        hands = {}

        2.times do
            (1..num_players).each do |i| 
                if(hands[i])
                    hands[i].push(deck.deal)
                else
                    hands[i] = [deck.deal]
                end
            end
        end

        return hands
    end

    def inspect
        "#<#{self.class}:#{self.object_id} @players=#{self.num_players} players>"
    end
end