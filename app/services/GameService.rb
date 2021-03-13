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
    def run_round(deck:, holes:, community:)
        burned = []
        
        # 1) Deal 2 cards to each player
        2.times{holes.each{|player, hole| hole.push(deck.deal) if hole.size < 2 }}
        deal_hands = holes.map{|player, hole| [player, identify(hole+community.values.flatten)]}.to_h
        deal_stats = calc_win_order(deal_hands)

        # 2) Burn one
        burned.push(deck.deal)

        # 3) Deal FLOP
        2.times{community.fetch(:flop, []).push(deck.deal) if community.fetch(:flop, []).size < 3 }
        flop_hands = holes.map{|player, hole| [player, identify(hole+community.values.flatten)]}.to_h
        flop_stats = calc_win_order(flop_hands)

        # 4) Burn one
        burned.push(deck.deal)

        # 5) Deal the TURN
        community.fetch(:turn, []).push(deck.deal) if community.fetch(:turn, []).size < 1
        turn_hands = holes.map{|player, hole| [player, identify(hole+community.values.flatten)]}.to_h
        turn_stats = calc_win_order(river_hands)

        # 6) Burn one
        burned.push(deck.deal)

        # 7) Deal the RIVER
        community.fetch(:river, []).push(deck.deal) if community.fetch(:river, []).size < 1
        river_hands = holes.map{|player, hole| [player, identify(hole+community.values.flatten)]}.to_h
        river_stats = calc_win_order(river_hands)

        return Round.new(
            deck: deck, 
            holes: holes, 
            community: community, 
            burned: burned, 
            deal_hands: deal_hands,
            flop_hands: flop_hands,
            turn_hands: turn_hands,
            river_hands: river_hands,
            win_stats: {deal: deal_stats, flop: flop_stats, turn: turn_stats, river: river_stats}
        )
    end

    # This is where we split into concurrent execution using actors
    # 
    # @param Integer round_count
    # @param Deck deck
    # @param {String => [Card]} holes
    # @param {String => [Card]} community
    # return [Round]
    def play_rounds(**kwargs)
        # {deck: deck, holes: holes, community: community}
        # round_count.times do
        #     an_actor = RoundActor.spawn name: 'an_actor', args: 10 
        #     an_actor << Message.new(:run, kwargs)
        # end

        # Creates a pool of RoundActor workers
        pool = Concurrent::Actor::Utils::Pool.spawn! 'pool', 10 do |index|
            RoundActor.spawn name: 'an_actor', supervise: True, args: []
        end

        pool.ask(:await)

        (1..round_count).map{|i| play_round()}
    end
    
    # def get_win_stats
    #     rounds.map{|r| r.get_winner[1]}
    #     .frequency{|hand| hand.metahand}
    #     .map{|k,v| [k.name, v]}
    #     .to_h
    # end

    # Given a hash of player number to best hand,
    # return an array of player numbers in order of
    # best hand
    # 
    # @param hands {1: <Hand ...>, 2: <Hand ...>, ...}
    def calc_win_order(hands)
        
        hands.sort_by{|player_num, hand| hand}

        

    end

end