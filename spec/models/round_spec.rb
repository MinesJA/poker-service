require 'rails_helper'

describe Round, '.new' do
    it 'is initialized with a deck, holes, community, burned, and hands' do
        round = Round.new(
            deck: Deck.new, 
            holes: Hash.new, 
            community: Array.new, 
            burned: Array.new, 
            deal_hands: Hash.new,
            flop_hands: Hash.new,
            turn_hands: Hash.new,
            river_hands: Hash.new,
        )

        expect(round.holes).to be_instance_of(Hash)
        expect(round.community).to be_instance_of(Array)
        expect(round.burned).to be_instance_of(Array)
        expect(round.deal_hands).to be_instance_of(Hash)
        expect(round.flop_hands).to be_instance_of(Hash)
        expect(round.turn_hands).to be_instance_of(Hash)
        expect(round.river_hands).to be_instance_of(Hash)

        expect(round.deck.cards.count).to eq 52
        deck = Deck.new
        round.deck.cards.each{ |card| expect(deck.contains(card)).to be true }
    end
end