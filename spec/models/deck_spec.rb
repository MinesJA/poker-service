require 'rails_helper'

describe Deck, '.new' do
    it 'creates a new deck with 52 cards' do
        deckA = Deck.new()
        deckB = Deck.new()
        
        # Exactly 52 cards
        expect(deckA.cards.size).to eql(52)
        expect(deckB.cards.size).to eql(52)
        
        # All unique
        expect(deckA.cards.uniq.size).to eql(52)
        expect(deckB.cards.uniq.size).to eql(52)
    end

    it 'produces shuffled deck' do
        deckA = Deck.new()
        deckB = Deck.new()
        
        # Contains same cards
        expect(deckA.cards - deckB.cards | deckB.cards - deckA.cards).to be_empty

        # But not equal because not in same sequence
        expect(deckA.cards).not_to eql(deckB.cards)
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

describe Deck, '#deal' do
    it 'deals a single card' do
        deck = Deck.new()
        expect(deck.size()).to eq(52)

        card = deck.deal()

        expect(card).to be_instance_of(Card)
        expect(deck.size()).to eq(51)
    end

    it 'does not deal a repeating card' do
        deck = Deck.new()
        card = deck.deal()

        deck.size().times do
            expect(card).not_to eq(deck.deal())
        end
    end

    it 'can not deal more cards than a 52 card deck' do
        deck = Deck.new()

        52.times do
            deck.deal()
        end

        #  Trying to deal the 53rd card 
        expect{ deck.deal() }.to raise_error(RuntimeError)
    end
end