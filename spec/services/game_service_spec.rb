require 'rails_helper'

describe GameService, '#run_round' do

    let(:mock_game_service) {Class.new { extend GameService } }

    it 'runs through a round given no constants' do
        round = mock_game_service.run_round(player_count: 6)
        
        expect(round).to be_instance_of(Round)
        expect(round.deck).to be_instance_of(Deck)

        expect(round.burned.size).to be(3)
        expect(round.holes.values.flatten.size).to be(12)
        
        expect(round.community.values.flatten.size).to be(5)

        expect(round.deal_hands.values.flatten.size).to be(6)
        expect(round.flop_hands.values.flatten.size).to be(6)
        expect(round.turn_hands.values.flatten.size).to be(6)
        expect(round.river_hands.values.flatten.size).to be(6)

        expect(round.deck.size).to be(32)
    end

    it 'runs through a round with some hole constants' do
        # TODO: This seems dumb to have to require
        holes = {
            2 => ["4C"],
            4 => ["5S", "8D"]
        }

        round = mock_game_service.run_round(player_count: 6, holes: holes)

        expect(round.holes.values.flatten.size).to be(12)

        round.holes[2].contains(Card.new(4, "Clubs"))
        round.holes[4] == [Card.new(5, "Spades"), Card.new(8, "Diamonds")]
    end

    it 'runs through a round with some community constants' do
        community = {
            :flop => ["4C"],
            :river => ["8D"]
        }

        round = mock_game_service.run_round(player_count: 6, community: community)

        expect(round.community.values.flatten.size).to be(5)

        round.community[:flop].contains(Card.new(4, "Clubs"))
        round.community[:river] == [Card.new(8, "Diamonds")]
    end

    it 'does not allow repeating cards to be dealt' do
         # TODO: This seems dumb to have to require
        holes = {
            2 => ["4C"],
            4 => ["4C"]
        }

        community = {
            :flop => ["4C"],
            :turn => ["4C"]
        }

        expect{mock_game_service.run_round(player_count: 6, holes: holes)}.to raise_error(RuntimeError)
        expect{mock_game_service.run_round(player_count: 6, community: community)}.to raise_error(RuntimeError)
        expect{mock_game_service.run_round(player_count: 6, community: community.slice(:flop), holes: holes.slice(2))}.to raise_error(RuntimeError)
    end

    

  

    holes = {
        1 => %w(1D 2D),
        2 => %w(1C 3H),
        3 => %w(1H 2H)
    }

    community = {
        :flop => %w(4C 6S 8D),
        :turn => %w(4C), #Pair on the turn for everyone
        :river => %w(AS)
    }

    it 'produces the right deal hands' do
        holes = {
            1 => %w(2D 2C), #Pair on deal
            2 => %w(1C 3H),
            3 => %w(1H 2H)
        }

        pair_cards = [
            Card.new(2, "Diamonds"),
            Card.new(2, "Clubs")
        ]

        round = mock_game_service.run_round(player_count: 3, holes: holes)
        expect(round.hand_deal[1]).to be_eql(Hand.new(type: :pair, cards: pair_cards))
        expect(round.hand_deal[2]).to be_eql(Hand.new(type: :high_card, cards: [Card.new(3,"Hearts")], kickers: [Card.new(1, "Clubs")]))
        expect(round.hand_deal[3]).to be_eql(Hand.new(type: :high_card, cards: [Card.new(2, "Hearts")], kickers: [Card.new(1, "Hearts")]))
    end

    it 'produces the right flop hands' do
        holes = {
            1 => %w(4C 2D),
            2 => %w(AC 3H),
            3 => %w(AH 2H)
        }
    
        community = {
            :flop => %w(4C 6S 8D)
        }

        pair_cards = [
            Card.new(2, "Diamonds"),
            Card.new(2, "Clubs")
        ]

        kickersA = [
            Card.new(2, "Diamonds"),
            Card.new(6, "Spades"),
            Card.new(8, "Diamonds")
        ]

        kickersB = [
            Card.new(3, "Hearts"),
            Card.new(4, "Clubs"),
            Card.new(6, "Spades"),
            Card.new(8, "Diamonds")
        ]

        kickersC = [
            Card.new(2, "Hearts"),
            Card.new(4, "Clubs"),
            Card.new(6, "Spades"),
            Card.new(8, "Diamonds")
        ]

        round = mock_game_service.run_round(player_count: 3, holes: holes)
        expect(round.flop_hands[1]).to be_eql(Hand.new(type: :pair, cards: pair_cards), kickers: kickers)
        expect(round.flop_hands[2]).to be_eql(Hand.new(type: :pair, cards: [Card.new("A","Clubs")], kickers: kickersB))
        expect(round.flop_hands[3]).to be_eql(Hand.new(type: :pair, cards: [Card.new("A", "Hearts")], kickers: kickersC))
    end

    it 'produces the right turn hands' do

    end

    it 'produces the right river hands' do

    end

    

end

describe GameService, '#run_rounds' do

    it 'runs throuhg a number of rounds and returns rounds' do


    end

    it 'benchmark test??' do
        # TODO: Maybe something like a simple loop running the run_round
        # x num of times compared to the actual method
        # Whatever method I have for running multiple rounds
        # Should always be faster
    end

end


# TODO: Could probably dry up the repeating testing like so:
# def has_right_cards(round)
#     expect(round.burned.size).to be(3)
#     expect(round.holes.values.flatten.size).to be(12)
    
#     expect(round.community.values.flatten.size).to be(5)

#     expect(round.deal_hands.values.flatten.size).to be(6)
#     expect(round.flop_hands.values.flatten.size).to be(6)
#     expect(round.turn_hands.values.flatten.size).to be(6)
#     expect(round.river_hands.values.flatten.size).to be(6)

#     expect(round.deck.size).to be(32)
# end