module GameService
    include IdentificationService

    # Takes a deck, hash of holes by players (for those holes that should
    # remain constant), and hash of community
    # cards by the type (Flop, turn, river)
    # Runs through entire round and returns a round object
    # 
    # @param Deck deck
    # @param {String => [Card]} prexisting holes
    # @param {String => [Card]} community
    # @return Round
    def play_round(deck:, holes:, community:)
        # TODO: next step would be to calculate winners at every state:
        #   After Deal
        #   After Flop
        #   After Turn: 
        #   After River
        #  Would result in:
        #     { 
        #       deal: {1: <Hand best hand>, ....},
        #       flop: {1: <Hand best hand>, ....},
        #       turn: {1: <Hand best hand>, ....},
        #       river: {1: <Hand best hand>, ....}
        #     }
        burned = []
        
        # 1) Deal 2 cards to each player
        2.times{holes.each{|player, hole| hole.push(deck.deal) if hole.size < 2 }}

        # 2) Burn one
        burned.push(deck.deal)

        # 3) Deal FLOP
        2.times{community.fetch(:flop, []).push(deck.deal) if community.fetch(:flop, []).size < 3 }

        # 4) Burn one
        burned.push(deck.deal)

        # 5) Deal the TURN
        community.fetch(:turn, []).push(deck.deal) if community.fetch(:turn, []).size < 1

        # 6) Burn one
        burned.push(deck.deal)

        # 7) Deal the RIVER
        community.fetch(:river, []).push(deck.deal) if community.fetch(:river, []).size < 1

        # 8) Calculate winners
        hands = holes.map{|player, hole| [player, identify(hole+community.values.flatten)]}.to_h

        return Round.new(deck: deck, holes: holes, community: community, burned: burned, hands: hands)
    end

    # @param Integer round_count
    # @param Deck deck
    # @param {String => [Card]} holes
    # @param {String => [Card]} community
    # return [Round]
    def play_rounds(round_count:, deck:, holes:, community:)
        (1..round_count).map{|i| play_round(deck: deck, holes: holes, community: community)}
    end
    
    # def get_win_stats
    #     rounds.map{|r| r.get_winner[1]}
    #     .frequency{|hand| hand.metahand}
    #     .map{|k,v| [k.name, v]}
    #     .to_h
    # end

end