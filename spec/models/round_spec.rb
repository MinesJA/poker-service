require 'rails_helper'

describe Round, '.new' do
    it 'is initilized with a table and empty params' do
        round = Round.new(table: build(:table))

        expect(round.table).to be_instance_of(Table)

        expect(round.holes).to be_empty
        expect(round.community).to be_empty
        expect(round.burned).to be_empty
        expect(round.hands).to be_empty

        expect(round.deck.cards.count).to eq 52
        deck = Deck.new
        round.deck.cards.each{ |card| expect(deck.contains(card)).to be true}
    end
end


describe Round, '#run_round' do
    it 'is initilized' do
        
        # tb = Table.new(player_names: ['Adam', 'Betty', 'Carl', 'Darlene', 'Evan', 'Francene'])
    
        # tb.run_rounds(1)
        # str = tb.rounds.values.first.to_s

        players = ['Adam', 'Betty', 'Carl', 'Darlene', 'Evan', 'Francene']

        # table = Table.new(player_names: players)

        stats = Table.new_and_run(player_names: players, count: 1)
        byebug

        
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