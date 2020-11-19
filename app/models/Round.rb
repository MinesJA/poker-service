class Round
    include IdentificationService

    attr_reader :deck, :table, :holes, :community, :burned, :hands
    
    RIVER = "river"
    TURN = "turn"
    FLOP = "flop"

    def initialize(table:)
        @deck = Deck.new()
        @table = table
        @holes = Hash.new{|h,k| h[k] = []}
        @community = Hash.new([])
        @burned = []
        @hands = Hash.new{|h,k| h[k] = []}
    end

    def run()
        # 1) Deal 2 cards to each player
        2.times do
            table.players.each{|player| holes[player].push(deck.deal)}
        end

        # 2) Burn one
        burned.push(deck.deal)

        # 3) Deal FLOP
        community[FLOP] = (0..2).map{|i| deck.deal}

        # 4) Burn one
        burned.push(deck.deal)

        # 5) Deal the TURN
        community[TURN] = [deck.deal]

        # 6) Burn one
        burned.push(deck.deal)

        # 7) Deal the RIVER
        community[RIVER] = [deck.deal]

        # 8) Calculate winners
        table.players.each{|player| hands[player] = identify(holes[player] + community.values.flatten)}

        return self
    end

    def get_winner
        return hands.max_by{|k,v| v.metahand.score}
    end

    def to_s
        winner = get_winner
        community.map{|k,v| 
            <<~HEREDOC
                #{k}
                #{v.map{|card| card.to_s + '\n'}.join('')}
            HEREDOC
        }

        community_cards = community.map{|k,v| "#{k} - \n\t\t #{v.map(&:to_s)}"}.join("\n\t")
        player_cards = holes.map{|player,cards| "#{player} - \n\t\t #{hands[player]} \n\t\t #{cards.map(&:to_s)}"}.join("\n\t")
        <<~HEREDOC
        Round: 
            Winner: #{winner[0]} with the #{winner[1]}

            Community cards: 
                #{community_cards}
            
            Player cards:
                #{player_cards}
        HEREDOC
    end


    # Players:
    # Carl FLUSH:
    #     Jack of Diamonds
    #     Ace of Spades

    # Kevin STRAIGHT:
    #     King of Spades
    #     Six of Clubs

    # Mary TWO PAIR:
    #     Eight of Hearts
    #     Eight of Clubs


    
end