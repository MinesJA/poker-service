class Round
    include IdentificationService

    attr_accessor :player_holes, :community_cards, :burn_pile
    
    RIVER = "river"
    TURN = "turn"
    FLOP = "flop"

    def initialize(table:)
        @deck = Deck.new()
        @table = table
        @holes = Hash.new([])
        @community = Hash.new([])
        @burned = []
        @hands = Hash.new()
        @winner = nil
    end

    def run_round()

        # 1) Deal 2 to each player
        2.times do
            table.players.each{|player| holes[player] = holes[player].push(deck.deal)}
        end
        
        # 2) Burn one
        burn_pile.push(deck.deal)

        # 3) Deal FLOP
        community[FLOP] = (0..2).map{|i| deck.deal}

        # 4) Burn one
        burned.push(deck.deal)

        # 5) Deal the TURN
        community[TURN] = [deck.deal]

        # 6) Burn one
        self.burn_pile.push(deck.deal)

        # 7) Deal the RIVER
        community[RIVER] = [deck.deal]

        # 8) Calculate winners
        players.each{|player| hands[player] = identify(holes[player] + community.values.flatten)}

        players.
    end
    
end