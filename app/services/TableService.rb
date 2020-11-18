class TableService

    attr_accessor :num_players, :player_holes, :community_cards, :burn_pile
    attr_reader :deck

    def initialize(num_players)
        @deck = Deck.new()
        @num_players = num_players
        @player_holes = {}
        @community_cards = setup_communit()
        @burn_pile = []
    end

    

    def inspect
        "#<#{self.class}:#{self.object_id} @players=#{self.num_players} players>"
    end
end