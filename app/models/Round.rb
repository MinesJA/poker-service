class Round
    attr_reader :deck, :holes, :community, :burned, :deal_hands, :flop_hands, :turn_hands, :river_hands, :win_hands
    
    # Object for storing results of a completed round.
    # Deck, holes, community, burned are all stored as
    # a way to track history and for potential audit.
    # 
    # Hands are hash of player_num to best hand they had
    # at a particular point in the game (after deal, 
    # after flop, etc.)
    # 
    # This should be the object for serialization to be sent
    # back in response to controller
    def initialize(
        deck:, 
        holes:, 
        community:, 
        burned:, 
        deal_hands:, 
        flop_hands:, 
        turn_hands:, 
        river_hands:
    )
        @deck = deck
        @holes = holes
        @community = community
        @burned = burned
        @deal_hands = deal_hands
        @flop_hands = flop_hands
        @turn_hands = turn_hands
        @river_hands = river_hands
    end

    def determine_win_hands()
        
        
        
    end


    # def <=>(round)
    #     self.round round.
    # end

    # {1: <Hand ...>, 2: <Hand ...>, ...}
    # Need to have record of best hands at every stage and ordering
    # [<Hand>, <Hand>, ]

    # TODO: Do we need to implement a serialization strategy via
    #   Marshal dump:
    #   https://blog.appsignal.com/2019/03/26/object-marshalling-in-ruby.html
    #   May need to do this for Cards and Hands as well



end