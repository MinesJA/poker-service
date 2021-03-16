require 'rails_helper'

describe Hand, '.new' do
    
    it 'creates a new hand with a type, cards and default kicker' do
        hand = Hand.new(type: :high_card, cards: [Card.new(2, "Diamonds")])
        
        expect(hand).to be_instance_of(Hand)
        
        expect(hand.type).to be_eql(:high_card)
        expect(hand.cards).to include(Card.new(2, "Diamonds"))
        
        expect(hand.kickers).to be_instance_of(Array)
        expect(hand.kickers).to be_empty()
    end

    it 'raises an error with an invalid type' do    
        # TODO: need to specify which error exactly. May need to change in actual raise
        expect{Hand.new(type: :fuzz, cards: [Card.new(2, "Diamonds")])}.to raise_error(ArgumentError)
    end

    it 'raises an error with empty array of cards' do    
        expect{Hand.new(type: :straight, cards: [])}.to raise_error(ArgumentError)
    end

    it 'raises an errory when more than 5 cards including kickers are passed in' do
        three_cards = [Card.new(2, "Diamonds"), 
                        Card.new(3, "Hearts"), 
                        Card.new(5, "Clubs")]

        expect{Hand.new(type: :straight, cards: three_cards, kickers: three_cards)}.to raise_error(ArgumentError)
    end

end

describe Hand, '#eql?' do

    it 'is equal with equal types' do
        cards = [Card.new(2, "Diamonds"), Card.new(3, "Hearts"), Card.new(5, "Clubs")]

        handA = Hand.new(type: :straight, cards: cards)
        handB = Hand.new(type: :straight, cards: cards.shuffle)

        handC = Hand.new(type: :three_kind, cards: cards)

        expect(handA).to be_eql(handB)
        expect(handA).to_not be_eql(handC)
    end

    it 'is equal with equal cards regardless of order' do
        cardsA = [Card.new(2, "Diamonds"), Card.new(3, "Hearts"), Card.new(5, "Clubs")]
        cardsB = [Card.new(2, "Diamonds"), Card.new(3, "Hearts"), Card.new(5, "Clubs")]

        cardsC = [Card.new(2, "Diamonds"), Card.new(3, "Spades"), Card.new(5, "Clubs")]

        kickers = [Card.new(2, "Spades")]

        handA = Hand.new(type: :straight, cards: cardsA, kickers: kickers)
        handB = Hand.new(type: :straight, cards: cardsB.shuffle, kickers: kickers.shuffle)

        handC = Hand.new(type: :straight, cards: cardsC.shuffle)

        expect(handA).to be_eql(handB)
        expect(handA).to_not be_eql(handC)
    end

    it 'is equal with equal kickers regardless of order' do
        cards = [Card.new(2, "Diamonds"), Card.new(3, "Hearts"), Card.new(5, "Clubs")]

        kickersA = [Card.new(2, "Spades"), Card.new(2, "Clubs")]
        kickersB = [Card.new(2, "Diamonds"), Card.new(9, "Diamonds")]

        handA = Hand.new(type: :straight, cards: cards, kickers: kickersA)
        handB = Hand.new(type: :straight, cards: cards.shuffle, kickers: kickersA.shuffle)
        handC = Hand.new(type: :straight, cards: cards, kickers: kickersB)

        expect(handA).to be_eql(handB)
        expect(handA).to_not be_eql(handC)
    end

end

describe Hand, '#<=>' do

    it 'can compare hands with unequal high cards' do
        handA = Hand.new(type: :high_card, cards: [Card.new(10, "Spades")])
        handB = Hand.new(type: :high_card, cards: [Card.new("A", "Spades")])
        handC = Hand.new(type: :high_card, cards: [Card.new(5, "Diamonds")])

        expect(handA <=> handB).to eq(-1)
        expect(handA <=> handC).to eq(1)
    end

    it 'can compare hands with equal high cards' do
        kickersA = [
            Card.new("J", "Diamonds"),
            Card.new(10, "Diamonds"),
            Card.new(6, "Spades"),
            Card.new(5, "Clubs")
        ].shuffle

        kickersB = [
            Card.new("J", "Diamonds"),
            Card.new(10, "Diamonds"),
            Card.new(8, "Spades"),
            Card.new(5, "Clubs")
        ].shuffle

        kickersC = [
            Card.new("J", "Diamonds"),
            Card.new(10, "Diamonds"),
            Card.new(6, "Spades"),
            Card.new(5, "Clubs")
        ].shuffle

        handA = Hand.new(type: :high_card, cards: [Card.new("A", "Spades")], kickers: kickersA)
        handB = Hand.new(type: :high_card, cards: [Card.new("A", "Spades")], kickers: kickersB)
        handC = Hand.new(type: :high_card, cards: [Card.new("A", "Spades")], kickers: kickersC)

        expect(handA <=> handB).to eq(-1)
        expect(handA <=> handC).to eq(0)
        expect(handB <=> handA).to eq(1)
    end

    it 'can compare hands with unequal pairs' do
        # Highest pair then
        # Compare up to 3 kickers
        handA = Hand.new(type: :pair, cards: [Card.new(10, "Spades"), Card.new(10, "Spades")])
        handB = Hand.new(type: :pair, cards: [Card.new("A", "Spades"), Card.new("A", "Spades")])
        handC = Hand.new(type: :pair, cards: [Card.new(5, "Diamonds"), Card.new(5, "Diamonds")])

        expect(handA <=> handB).to eq(-1)
        expect(handA <=> handC).to eq(1)
    end

    it 'can compare hands with equal pairs' do
        cards = [
            Card.new(10, "Spades"), 
            Card.new(10, "Clubs")
        ]

        kickersA = [
            Card.new("J", "Diamonds"),
            Card.new(10, "Diamonds"),
            Card.new(6, "Spades")
        ].shuffle

        kickersB = [
            Card.new("J", "Diamonds"),
            Card.new(10, "Diamonds"),
            Card.new(8, "Spades")
        ].shuffle

        kickersC = [
            Card.new("J", "Diamonds"),
            Card.new(10, "Diamonds"),
            Card.new(6, "Spades"),
        ].shuffle

        handA = Hand.new(type: :pair, cards: cards, kickers: kickersA)
        handB = Hand.new(type: :pair, cards: cards, kickers: kickersB)
        handC = Hand.new(type: :pair, cards: cards, kickers: kickersC)

        expect(handA <=> handB).to eq(-1)
        expect(handA <=> handC).to eq(0)
        expect(handB <=> handA).to eq(1)
    end

    it 'can compare hands with unequal two pairs' do

        cardsA = [
            Card.new(10, "Diamonds"), 
            Card.new(10, "Spades"), 
            Card.new(5, "Clubs"),
            Card.new(5, "Hearts")
        ].shuffle
        
        cardsB = [
            Card.new("A", "Diamonds"), 
            Card.new("A", "Spades"), 
            Card.new(5, "Clubs"),
            Card.new(5, "Hearts")
        ].shuffle

        cardsC = [
            Card.new(10, "Diamonds"), 
            Card.new(10, "Spades"), 
            Card.new(8, "Clubs"),
            Card.new(8, "Hearts")
        ].shuffle

        handA = Hand.new(type: :two_pair, cards: cardsA)
        handB = Hand.new(type: :two_pair, cards: cardsB)
        handC = Hand.new(type: :two_pair, cards: cardsC)

        expect(handA <=> handB).to eq(-1)
        expect(handA <=> handC).to eq(-1)
        expect(handB <=> handC).to eq(1)
    end

    it 'can compare hands with equal two pairs' do
        cards = [
            Card.new(10, "Spades"), 
            Card.new(10, "Spades")
        ]

        kickersA = [
            Card.new("J", "Diamonds"),
            Card.new(10, "Diamonds"),
            Card.new(6, "Spades")
        ].shuffle

        kickersB = [
            Card.new("J", "Diamonds"),
            Card.new(10, "Diamonds"),
            Card.new(8, "Spades")
        ].shuffle

        handA = Hand.new(type: :two_pair, cards: cards, kickers: kickersA)
        handB = Hand.new(type: :two_pair, cards: cards, kickers: kickersB)

        expect(handA <=> handB).to eq(-1)
        expect(handA <=> handA).to eq(0)
        expect(handB <=> handA).to eq(1)
    end

    it 'can compare hands with unequal three of a kind' do
        cardsA = [
            Card.new(10, "Diamonds"),
            Card.new(10, "Clubs"),
            Card.new(10, "Spades")
        ]

        cardsB = [
            Card.new("K", "Diamonds"),
            Card.new("K", "Clubs"),
            Card.new("K", "Spades")
        ]

        cardsC = [
            Card.new(6, "Diamonds"),
            Card.new(6, "Diamonds"),
            Card.new(6, "Spades"),
        ]

        handA = Hand.new(type: :three_kind, cards: cardsA)
        handB = Hand.new(type: :three_kind, cards: cardsB)
        handC = Hand.new(type: :three_kind, cards: cardsC)

        expect(handA <=> handB).to eq(-1)
        expect(handB <=> handC).to eq(1)
    end

    it 'can compare hands with equal three of a kind' do
        cards = [
            Card.new(10, "Diamonds"),
            Card.new(10, "Clubs"),
            Card.new(10, "Spades")
        ]
        
        kickersA = [
            Card.new("J", "Spades"),
            Card.new(8, "Spades")
        ].shuffle
        
        kickersB = [
            Card.new("J", "Clubs"),
            Card.new(10, "Clubs")
        ].shuffle

        kickersC = [
            Card.new("J", "Diamonds"),
            Card.new(10, "Spades")
        ].shuffle

        handA = Hand.new(type: :three_kind, cards: cards, kickers: kickersA)
        handB = Hand.new(type: :three_kind, cards: cards, kickers: kickersB)
        handC = Hand.new(type: :three_kind, cards: cards, kickers: kickersC)

        expect(handA <=> handB).to eq(-1)
        expect(handB <=> handC).to eq(0)
        expect(handC <=> handA).to eq(1)
    end

    it 'can compare hands with equal and unequal straight' do
        cardsA = [
            Card.new(9, "Diamonds"),
            Card.new(8, "Diamonds"),
            Card.new(7, "Spades"),
            Card.new(6, "Clubs"),
            Card.new(5, "Clubs")
        ].shuffle
        
        cardsB = [
            Card.new("J", "Diamonds"),
            Card.new(10, "Diamonds"),
            Card.new(9, "Spades"),
            Card.new(8, "Clubs"),
            Card.new(7, "Clubs")
        ].shuffle

        cardsC = [
            Card.new("A", "Diamonds"),
            Card.new("K", "Diamonds"),
            Card.new("Q", "Spades"),
            Card.new("J", "Clubs"),
            Card.new(10, "Clubs")
        ].shuffle

        handA = Hand.new(type: :straight, cards: cardsA)
        handB = Hand.new(type: :straight, cards: cardsB)
        handC = Hand.new(type: :straight, cards: cardsC)

        expect(handA <=> handB).to eq(-1)
        expect(handA <=> handA).to eq(0)
        expect(handC <=> handB).to eq(1)
    end

    it 'can compare hands with equal and unequal flush' do
        cardsA = [
            Card.new("J", "Diamonds"),
            Card.new(10, "Diamonds"),
            Card.new(6, "Diamonds"),
            Card.new(7, "Diamonds"),
            Card.new(8, "Diamonds")
        ].shuffle

        cardsB = [
            Card.new("J", "Clubs"),
            Card.new("K", "Clubs"),
            Card.new(6, "Clubs"),
            Card.new(2, "Clubs"),
            Card.new(8, "Clubs")
        ].shuffle

        cardsC = [
            Card.new(4, "Spades"),
            Card.new(10, "Spades"),
            Card.new(6, "Spades"),
            Card.new(7, "Spades"),
            Card.new(8, "Spades")
        ].shuffle

        handA = Hand.new(type: :flush, cards: cardsA)
        handB = Hand.new(type: :flush, cards: cardsB)
        handC = Hand.new(type: :flush, cards: cardsC)

        expect(handA <=> handB).to eq(-1)
        expect(handA <=> handA).to eq(0)
        expect(handA <=> handC).to eq(1)
    end

    it 'can compare hands with equal and unequal full house' do
        cardsA = [
            Card.new(9, "Clubs"),
            Card.new(9, "Diamonds"),
            Card.new(9, "Hearts"),
            Card.new(6, "Diamonds"),
            Card.new(6, "Clubs")
        ].shuffle
        
        cardsB = [
            Card.new(10, "Clubs"),
            Card.new(10, "Diamonds"),
            Card.new(10, "Hearts"),
            Card.new(6, "Diamonds"),
            Card.new(6, "Clubs")
        ].shuffle

        cardsC = [
            Card.new(9, "Clubs"),
            Card.new(9, "Diamonds"),
            Card.new(9, "Hearts"),
            Card.new("A", "Diamonds"),
            Card.new("A", "Clubs")
        ].shuffle

        handA = Hand.new(type: :full_house, cards: cardsA)
        handB = Hand.new(type: :full_house, cards: cardsB)
        handC = Hand.new(type: :full_house, cards: cardsC)

        expect(handA <=> handB).to eq(-1)
        expect(handA <=> handA).to eq(0)
        expect(handB <=> handC).to eq(1)
    end

    it 'can compare hands with unequal four of a kind' do
        cardsA = [
            Card.new(10, "Diamonds"),
            Card.new(10, "Clubs"),
            Card.new(10, "Spades"),
            Card.new(10, "Hearts")
        ]

        cardsB = [
            Card.new("K", "Diamonds"),
            Card.new("K", "Clubs"),
            Card.new("K", "Spades"),
            Card.new("K", "Hearts")
        ]

        cardsC = [
            Card.new(6, "Diamonds"),
            Card.new(6, "Diamonds"),
            Card.new(6, "Spades"),
            Card.new(6, "Hearts")
        ]

        handA = Hand.new(type: :four_kind, cards: cardsA)
        handB = Hand.new(type: :four_kind, cards: cardsB)
        handC = Hand.new(type: :four_kind, cards: cardsC)

        expect(handA <=> handB).to eq(-1)
        expect(handB <=> handC).to eq(1)
    end

    it 'can compare hands with equal four of a kind' do
        cards = [
            Card.new(10, "Diamonds"),
            Card.new(10, "Clubs"),
            Card.new(10, "Spades"),
            Card.new(10, "Hearts")
        ]

        handA = Hand.new(type: :four_kind, cards: cards, kickers: [Card.new(8, "Clubs")])
        handB = Hand.new(type: :four_kind, cards: cards, kickers: [Card.new("J", "Clubs")])

        expect(handA <=> handB).to eq(-1)
        expect(handA <=> handA).to eq(0)
        expect(handB <=> handA).to eq(1)
    end

    it 'can compare hands with equal and unequal straight flush' do
        cardsA = [
            Card.new(9, "Diamonds"),
            Card.new(8, "Diamonds"),
            Card.new(7, "Spades"),
            Card.new(6, "Clubs"),
            Card.new(5, "Clubs")
        ].shuffle
        
        cardsB = [
            Card.new("J", "Diamonds"),
            Card.new(10, "Diamonds"),
            Card.new(9, "Spades"),
            Card.new(8, "Clubs"),
            Card.new(7, "Clubs")
        ].shuffle

        cardsC = [
            Card.new("A", "Diamonds"),
            Card.new("K", "Diamonds"),
            Card.new("Q", "Spades"),
            Card.new("J", "Clubs"),
            Card.new(10, "Clubs")
        ].shuffle

        handA = Hand.new(type: :straight_flush, cards: cardsA)
        handB = Hand.new(type: :straight_flush, cards: cardsB)
        handC = Hand.new(type: :straight_flush, cards: cardsC)

        expect(handA <=> handB).to eq(-1)
        expect(handA <=> handA).to eq(0)
        expect(handC <=> handB).to eq(1)
    end

    it 'can compare hands with royal flush' do
        cardsA = [
            Card.new("A", "Diamonds"),
            Card.new("K", "Diamonds"),
            Card.new("Q", "Diamonds"),
            Card.new("J", "Diamonds"),
            Card.new(10, "Diamonds")
        ].shuffle

        cardsB = [
            Card.new("A", "Clubs"),
            Card.new("K", "Clubs"),
            Card.new("Q", "Clubs"),
            Card.new("J", "Clubs"),
            Card.new(10, "Clubs")
        ].shuffle

        handA = Hand.new(type: :royal_flush, cards: cardsA)
        handB = Hand.new(type: :royal_flush, cards: cardsB)

        expect(handA <=> handB).to eq(0)
    end

end