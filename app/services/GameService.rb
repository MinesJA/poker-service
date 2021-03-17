module GameService
    include IdentificationService

    # Holes and Community are hashes that should represent any 
    # constants that should exist throughout round. For example, 
    # if player 1 should get an Ace of Spades in the deal, 
    # the holes would be: {1: [<Card Ace of Spades>]}
    # 
    # The deck should be the leftover deck, after giving out the constants
    # ensuring the constants are duplicated in the game.
    # 
    # Should run through a round, producing a typical Round object
    # 
    # @param {Integer => [String]} holes_short short names for hole constants by player number
    # @param {Symbol => [String]} community_short short names for community constants by stage symbol
    # @return Round
    def run_round(player_count:, deck: nil, holes: {}, community: {})
        deck = Deck.new() if deck.nil?
        holes.default_proc = proc{|h, k| h[k] = []}
        community.default_proc = proc{|h, k| h[k] = []}
        burned = []
        
        2.times do |i|
            1.upto(player_count) do |player|
                if(holes[player].size < 2)
                    holes[player].push(deck.deal)
                end
            end
        end
        deal_hands = holes.map{|player, hole| [player, identify(hole)]}.to_h

        # 2) Burn one
        burned.push(deck.deal)
        
        # 3) Deal FLOP
        community[:flop].push(*deck.deal_many(3 - community[:flop].size))
        flop_hands = holes.map{|player, hole| [player, identify(hole+community[:flop])]}.to_h

        # 4) Burn one
        burned.push(deck.deal)

        # 5) Deal the TURN
        community[:turn].push(deck.deal) unless community[:turn].any?
        turn_hands = holes.map{|player, hole| [player, identify(hole + community[:flop] + community[:turn])]}.to_h

        # 6) Burn one
        burned.push(deck.deal)

        # 7) Deal the RIVER
        community[:river].push(deck.deal) unless community[:river].any?
        river_hands = holes.map{|player, hole| [player, identify(hole + community.values.flatten)]}.to_h

        return Round.new(
            deck: deck, 
            holes: holes, 
            community: community, 
            burned: burned, 
            deal_hands: deal_hands,
            flop_hands: flop_hands,
            turn_hands: turn_hands,
            river_hands: river_hands,
        )
    end

    # Running multiple rounds and return array of all rounds
    # 
    # This is where we split into parrallel execution
    # 
    # @param Integer round_count
    # @param Deck deck
    # @param {String => [Card]} holes
    # @param {String => [Card]} community
    # return [Round]
    def run_rounds(run_count:, player_count:, holes:, community:)
        # TODO: implement parralel execution
        # https://www.toptal.com/ruby/ruby-concurrency-and-parallelism-a-practical-primer

        # pool_count.times do |x|
        #     fork do
        #         rounds.push(*(1..per_fork_count).map do |y|
        #             run_round(player_count: player_count, deck: deck, holes: holes, community: community)
        #         end)
        #     end
        # end

        # fork do
        #     rounds.push(*(1..left_over).map do |y|
        #         run_round(player_count: player_count, deck: deck, holes: holes, community: community)
        #     end)
        # end
        # Process.waitall

        return (0..run_count).map do |i| 
            d = Deck.new()
            h = game_params[:holes].to_h.map do |player, card_shorts|
                [player, card_shorts.map{|s| d.pull_short(s)}] 
            end.to_h

            c = game_params[:community].to_h.map do |player, card_shorts|
                [player, card_shorts.map{|s| d.pull_short(s)}]
            end.to_h
            
            run_round(player_count: player_count, deck: d, holes: h, community: c)
        end
    end
    

end