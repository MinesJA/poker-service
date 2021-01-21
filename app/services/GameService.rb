module GameService
    include IdentificationService

    RIVER = "river"
    TURN = "turn"
    FLOP = "flop"

    def run_round(table:)
        
        deck = Deck.new()
        holes = Hash.new{|h,k| h[k] = []}
        community = Hash.new([])
        burned = []
        hands = Hash.new{|h,k| h[k] = []}
        
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

        return Round.new(deck: deck, holes: holes, community: community, burned: burned, hands: hands)
    end



end