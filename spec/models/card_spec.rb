require 'rails_helper'

describe Card, '.new' do
    it 'creates a new card with a rank and suit' do
        card = Card.new(Rank::TEN, Suit::ACE)

        expect(card).to be_instance_of(Card)

        expect(card.rank).to be_eq(Rank::TEN)
        expect(card.suit).to be_eq(Suit::ACE)
    end

    
end

describe Card, '#eql?' do
    it 'is equal with equal rank and suit' do
        cardA = Card.new(Rank::TEN, Suit::ACE)
        cardB = Card.new(Rank::TEN, Suit::ACE)

        cardC = Card.new(Rank::NINE, Suit::ACE)

        expect(cardA).to be_eq(cardB)
        expect(cardA).to_not be_eq(cardC)
    end
end