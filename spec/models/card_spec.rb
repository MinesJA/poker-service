require 'rails_helper'

describe Card, '.new' do
    it 'creates a new card with a rank and suit' do
        card = Card.new(rank: Rank::TEN, suit: Suit::CLUBS)

        expect(card).to be_instance_of(Card)

        expect(card.rank).to be_eql(Rank::TEN)
        expect(card.suit).to be_eql(Suit::CLUBS)
    end

    
end

describe Card, '#eql?' do
    it 'is equal with equal rank and suit' do
        cardA = Card.new(rank: Rank::TEN, suit: Suit::CLUBS)
        cardB = Card.new(rank: Rank::TEN, suit: Suit::CLUBS)

        cardC = Card.new(rank: Rank::NINE, suit: Suit::CLUBS)

        expect(cardA).to be_eql(cardB)
        expect(cardA).to_not be_eql(cardC)
    end
end

describe Card, '.from_str' do
    it 'creates a card from the short name of card' do
    Card.from_str("KD")
    
    end
end