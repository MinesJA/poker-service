require 'rails_helper'

describe Round, '.new' do
    it 'creates a new Round with....' do

    end
end


describe Round, '#run_round' do
    it 'runs a new Round with....' do
        
        # tb = Table.new(player_names: ['Adam', 'Betty', 'Carl', 'Darlene', 'Evan', 'Francene'])
    
        # tb.run_rounds(1)
        # str = tb.rounds.values.first.to_s

        players = ['Adam', 'Betty', 'Carl', 'Darlene', 'Evan', 'Francene']

        Table.run_and_print(players)

        
    end

    it 'splits the win when...' do
        community = [
            Card.new(rank: Rank::TEN, suit: Suit::HEARTS),
            Card.new(rank: Rank::THREE, suit: Suit::DIAMONDS),
            Card.new(rank: Rank::EIGHT, suit: Suit::SPADES),
            Card.new(rank: Rank::TWO, suit: Suit::DIAMONDS),
            Card.new(rank: Rank::NINE, suit: Suit::HEARTS)
        ]

        # player1 = [Card.new(rank: Rank::QUEEN, Sui)]

        # Straight 
        #  ["queen of clubs", "jack of hearts", "king of hearts", "three of spades"]
         
        #  Francene - 
		#  Straight 
		#  ["queen of hearts", "jack of spades", "king of clubs", "nine of spades"]
    end

end