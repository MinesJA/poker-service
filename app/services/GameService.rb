module GameService
    include IdentificationService

    # TODO: Should have a defaults that creates
    # all defaults
    # def run_with_defaults(num_players)
    # end


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
    def run_round(num_players:, holes_shorts: {}, community_shorts: {})
        deck = Deck.new()

        holes = Hash.new{|h, k| h[k] = []}
        community = Hash.new{|h, k| h[k] = []}
            
        2.times do |i|
            1.upto(num_players) do |player|
                h_shorts = holes_shorts.fetch(player, [])
                if h_shorts[i].nil?
                    holes[player].push(deck.deal)
                else
                    holes[player].push(deck.pull_short(h_shorts[i]))
                end
            end
        end
        deal_hands = holes.map{|player, hole| [player, identify(hole)]}.to_h

        # 2) Burn one
        burned.push(deck.deal)
        
        # 3) Deal FLOP
        f_shorts = community_shorts.fetch(:flop, [])
        (0..2).map do |i| 
            f_card = f_shorts[i].nil? ? deck.deal() : deck.pull_short(f_shorts[i])
            community[:flop].push(f_card)
        end
        flop_hands = holes.map{|player, hole| [player, identify(hole+community[:flop])]}.to_h

        # 4) Burn one
        burned.push(deck.deal)

        # 5) Deal the TURN
        t_short = community_shorts.fetch(:flop, []).first
        t_card = t_short.nil? ? deck.deal() : deck.pull_short(t_short)
        community[:turn].push(t_card)
        turn_hands = holes.map{|player, hole| [player, identify(hole + community[:flop] + community[:turn])]}.to_h

        # 6) Burn one
        burned.push(deck.deal)

        # 7) Deal the RIVER
        r_short = community_shorts.fetch(:river, []).first
        r_card = r_card.nil? ? deck.deal() : deck.pull_short(r_short)
        community[:turn].push(r_card)
        turn_hands = holes.map{|player, hole| [player, identify(hole + community.values.flatten)]}.to_h

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
    def play_rounds(round_count:, deck:, holes:, community:)
        # TODO: implement parralel execution
        # https://www.toptal.com/ruby/ruby-concurrency-and-parallelism-a-practical-primer

        return (1..round_count).map{|i| play_round(deck: deck, holes: holes, community: community)}
    end
    

end