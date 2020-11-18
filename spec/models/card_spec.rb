require 'rails_helper'

describe Card, '.new' do
    it 'creates a new card with a rank and suit' do
        card = Card.new(Rank::TEN, Suit::CLUBS)

        expect(card).to be_instance_of(Card)

        expect(card.rank).to be_eql(Rank::TEN)
        expect(card.suit).to be_eql(Suit::CLUBS)
    end

    
end

describe Card, '#eql?' do
    it 'is equal with equal rank and suit' do
        cardA = Card.new(Rank::TEN, Suit::CLUBS)
        cardB = Card.new(Rank::TEN, Suit::CLUBS)

        cardC = Card.new(Rank::NINE, Suit::CLUBS)

        expect(cardA).to be_eql(cardB)
        expect(cardA).to_not be_eql(cardC)
    end
end