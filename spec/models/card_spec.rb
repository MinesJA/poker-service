require 'rails_helper'

describe Card, '.new' do
    it 'creates a new card with a rank and suit' do
        card = Card.new(Rank::TEN, Suit::CLUBS)

        expect(card).to be_instance_of(Card)

        expect(card.rank.name).to be_eq(Rank::TEN.name)
        expect(card.suit.name).to be_eq(Suit::CLUBS.name)
    end

    
end

describe Card, '#eql?' do
    it 'is equal with equal rank and suit' do
        cardA = Card.new(Rank::TEN, Suit::CLUBS)
        cardB = Card.new(Rank::TEN, Suit::CLUBS)

        cardC = Card.new(Rank::NINE, Suit::CLUBS)

        expect(cardA).to be_eq(cardB)
        expect(cardA).to_not be_eq(cardC)
    end
end