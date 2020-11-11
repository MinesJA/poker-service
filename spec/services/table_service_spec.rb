require 'rails_helper'

describe TableService, '.new' do
    it 'should be created with a new deck' do
        num_players = 5

        tb = TableService.new(num_players)
        
        expect(tb.deck.size).to be_eql(52)
    end

    it 'should be created with right number players' do
        num_players = 5

        tb = TableService.new(num_players)
        
        expect(tb.num_players).to be_eql(5)
    end
end

describe TableService, '#run_round' do
    it 'should be able to run round' do
        num_players = 5

        tb = TableService.new(num_players)

        expect(tb.deck.size).to be_eql(52)

        tb.run_round()
        
        burned_count = tb.burn_pile.size
        hole_count = tb.player_holes.values.flatten.size()
        community_count = tb.community_cards.size()
        
        expect(burned_count).to be_eql(3)
        expect(hole_count).to be_eql(num_players*2)
        expect(community_count).to be_eql(5)

        leftovers = 52 - (burned_count + hole_count + community_count)
        
        expect(tb.deck.size).to be_eql(leftovers)

        expect(tb.player_holes.values.size).to be_eql(5)
    end
end