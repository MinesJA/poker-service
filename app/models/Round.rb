class Round
    attr_reader :deck, :holes, :community, :burned, :hands
    
    def initialize(deck:, holes:, community:, burned:, hands:)
        @deck = deck
        @holes = holes
        @community = community
        @burned = burned
        @hands = hands
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
end