class Round
    attr_reader(
        :deck, :holes, :community, :burned, 
        :deal_hands, :flop_hands, :turn_hands, :river_hands
    )
    
    # Object for storing results of a completed round.
    # Deck, holes, community, burned are all stored as
    # a way to track history and for potential audit.
    # 
    # Hands are hash of player_num to best hand they had
    # at that particular point in the game (after deal, 
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

    def marshal_dump
        # TODO: implment strategy that produces:
        # <Card rank=King suit=Diamonds> => "KD"
        # 
        # {}.tap do |result|
        #   result[:age]      = age
        #   result[:fullname] = fullname if fullname.size <= 64
        #   result[:roles]    = roles unless roles.include? :admin
        # end
    end
    
    def marshal_load(serialized_user)
        # TODO: implment strategy that takes:
        # "KD" => <Card rank=King suit=Diamonds>
        # or "King Diamonds" => <Card rank=King suit=Diamonds>
        # 
        # self.age      = serialized_user[:age]
        # self.fullname = serialized_user[:fullname]
        # self.roles    = serialized_user[:roles] || []
    end

    def as_json(options)
        super.except(*["deck", "burned"])
    end

end