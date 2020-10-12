require 'rails_helper'


describe Deck, '.new' do
    it 'creates a new deck with 52 cards' do
        deckA = Deck.new()
        deckB = Deck.new()
        
        # Exactly 52 cards
        expect(deckA.size).to eql(52)
        expect(deckB.size).to eql(52)
        
        # All unique
        expect(deckA.cards.uniq.size).to eql(52)
        expect(deckB.cards.uniq.size).to eql(52)

        
    end

    it 'shuffles cards' do
        deckA = Deck.new()
        deckB = Deck.new()

        # Contains same cards
        expect(deckA.cards - deckB.cards | deckB.cards - deckA.cards).to be_empty

        # But not equal because not in same sequence
        expect(deckA).not_to eql(deckB)
    end

    it 'contains all the right cards' do 
        expect(Suit::ALL.size).to eql(4)
        expect(Rank::ALL.size).to eql(13)
    
        cards = Suit::ALL.flat_map{ |s|
            Rank::ALL.map { |r| Card.new(r,s) }
        }
    
        expect(cards.size).to eql(52)
    
        deck = Deck.new()
    
        cards.each{ |card| expect(deck.contains(card)).to be true}
    end
end