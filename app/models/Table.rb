class Table

    attr_accessor :num_players, :player_holes, :community_cards, :burn_pile
    attr_reader :deck

    def initialize(players:)
        @players = players
        @rounds = []
        
    end


end