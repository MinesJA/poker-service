class Round
    attr_reader :deck, :holes, :community, :burned, :hands
    
    # Object for storing results of a completed round
    # should include the remaining deck (after dealing)
    # the player holes, the community cards, and the
    # burned pile.

    # This should be the object for serialization to be sent
    # back in in response to controller
    # 
    # Also includes the hands in the form of:
    # {[player_num]: Hand<best hand>}
    def initialize(deck:, holes:, community:, burned:, deal_hands:, flop_hands:, turn_hands:, river_hands:)
        @deck = deck
        @holes = holes
        @community = community
        @burned = burned
        @deal_hands = deal_hands
        @flop_hands = flop_hands
        @turn_hands = turn_hands
        @river_hands = river_hands
    end



end