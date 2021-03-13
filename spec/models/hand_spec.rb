require 'rails_helper'

describe Hand, '.new' do
    
    it 'creates a new hand with a type, cards and default kicker' do
        hand = Hand.new(type: :high_card, cards: [Card.new(2, "D")])
        
        expect(hand).to be_instance_of(Hand)
        
        expect(hand.type).to be_eql(:high_card)
        expect(hand.cards).to include(Card.new(2, "D"))
        
        expect(hand.kicker).to be_instance_of(Array)
        expect(hand.kicker).to be_empty()
    end

    it 'raises an error with an invalid type' do    
        expect{Hand.new(type: :fuzz, cards: [Card.new(2, "D")])}.to raise_error("Invalid type")
    end

    it 'raises an error with empty array of cards' do    
        expect{Hand.new(type: :straight, cards: [])}.to raise_error("Cards cannot be empty")
    end

end

describe Hand, '#eql?' do

    it 'is equal with equal types' do
        cards = [Card.new(2, "D"), Card.new(3, "H"), Card.new(5, "C")]

        handA = Hand.new(type: :straight, cards: cards)
        handB = Hand.new(type: :straight, cards: cards.shuffle)

        handC = Hand.new(type: :three_kind, cards: cards)

        expect(handA).to be_eql(handB)
        expect(handA).to_not be_eql(handC)
    end

    it 'is equal with equal cards regardless of order' do
        cardsA = [Card.new(2, "D"), Card.new(3, "Hearts"), Card.new(5, "C")]
        cardsB = [Card.new(2, "D"), Card.new(3, "Hearts"), Card.new(5, "C")]

        cardsC = [Card.new(2, "D"), Card.new(3, "Spades"), Card.new(5, "C")]

        kicker = [Card.new(2, "Spades")]

        handA = Hand.new(type: :straight, cards: cardsA, kicker: kicker)
        handB = Hand.new(type: :straight, cards: cardsB.shuffle, kicker: kicker.shuffle)

        handC = Hand.new(type: :straight, cards: cardsC.shuffle)

        expect(handA).to be_eql(handB)
        expect(handA).to_not be_eql(handC)
    end

    it 'is equal with equal kickers regardless of order' do
        cards = [Card.new(2, "Diamonds"), Card.new(3, "Hearts"), Card.new(5, "Clubs")]

        kickerA = [Card.new(2, "Spades"), Card.new(2, "Clubs")]
        kickerB = [Card.new(2, "Diamonds"), Card.new(9, "Diamonds")]

        handA = Hand.new(type: :straight, cards: cards, kicker: kickerA)
        handB = Hand.new(type: :straight, cards: cards.shuffle, kicker: kickerB.shuffle)

        expect(handA).to be_eql(handB)
        expect(handA).to_not be_eql(handC)
    end

end

describe Hand, '#<=>' do
    it 'can sort '

end