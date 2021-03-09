require 'rails_helper'

describe GameService, '#run_round' do

    let(:mock_class) {Class.new { extend GameService } }

    it 'runs through a round given a table' do
        # Todo: TESTS
        
        # round = mock_class.play_round()

        # expect(round).not_to be_nil

        # expect(round.deck).to be_instance_of(Deck)
        # expect(round.deck.cards).not_to be_empty
        # expect(round.deck.cards.size).to be < 52

        # expect(round.holes).not_to be_empty
        # expect(round.community).not_to be_empty
        # expect(round.burned).not_to be_empty
        # expect(round.hands).not_to be_empty
    end

end