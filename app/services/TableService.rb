class TableService

    attr_accessor :deck, :num_players, :player_hands, :table_hand

    def initialize(num_players)
        @deck = Deck.new()
        @num_players = num_players
        @player_hands = {}
        @table_hand = []
    end

    def run_round()
        deal()
        
        # Burn a card
        deck.deal

        # Deal the Flop
        3.times do
            table_hand.push(deck.deal)
        end

        # Burn a card
        deck.deal

        # Deal the turn
        table_hand.push(deck.deal)

        # Burn a card
        deck.deal

        # Deal the river
        table_hand.push(deck.deal)
    end

    def deal()
       2.times do
            for i in 0..num_players
                if(player_hands[i])
                    player_hands[i].push(deck.deal)
                else
                    self.player_hands[i] = [deck.deal]
                end
            end
        end
    end
end