require 'rails_helper'


describe IdentificationService, '#identify' do

    let(:mock_class) {Class.new { extend IdentificationService } }

    it 'can identify a Pair with right cards' do
        cardsA = [
            Card.new(4, "Hearts"), 
            Card.new(4, "Clubs"),
            Card.new("A", "Spades"), 
        ]

        cardsB = [
            Card.new(4, "Hearts"), 
            Card.new(3, "Hearts"), 
            Card.new("K", "Diamonds"), 
            Card.new(4, "Clubs"), 
            Card.new("A", "Spades"), 
            Card.new("J", "Hearts"), 
            Card.new(2, "Clubs")
        ]

        expected_cards = [
            Card.new(4, "Hearts"), 
            Card.new(4, "Clubs")
        ]

        expectedA = Hand.new(type: :pair , cards: expected_cards, kickers: [Card.new("A", "Spades")])
        expectedB = Hand.new(type: :pair , cards: expected_cards, kickers: [Card.new("A", "Spades"), Card.new("J", "Hearts"), Card.new("K", "Diamonds")])

        handA = mock_class.identify(cardsA)
        handB = mock_class.identify(cardsB)

        expect(handA).to eq(expectedA)
        expect(handB).to eq(expectedB)
    end

    it 'can identify a Two Pair' do
        cardsA = [
            Card.new(4, "Hearts"), 
            Card.new("A", "Spades"),
            Card.new(4, "Clubs"),
            Card.new("A", "Diamonds"),
            Card.new("K", "Diamonds"),
        ]

        cardsB = [
            Card.new(4, "Hearts"), 
            Card.new(3, "Hearts"), 
            Card.new("K", "Diamonds"), 
            Card.new(4, "Clubs"), 
            Card.new("A", "Spades"), 
            Card.new("J", "Hearts"), 
            Card.new("A", "Diamonds")
        ]

        expected_cards = [
            Card.new("A", "Diamonds"), 
            Card.new("A", "Spades"),
            Card.new(4, "Hearts"), 
            Card.new(4, "Clubs")
        ]

        expected = Hand.new(type: :two_pair, cards: expected_cards, kickers: [Card.new("K", "Diamonds")])

        handA = mock_class.identify(cardsA)
        handB = mock_class.identify(cardsB)

        expect(handA).to eq(expected)
        expect(handB).to eq(expected)
    end

    it 'can identify a Three of a Kind' do
        cardsA = [
            Card.new(4, "Hearts"), 
            Card.new(4, "Spades"),
            Card.new(4, "Clubs"),
            Card.new("A", "Diamonds")
        ]

        cardsB = [
            Card.new(4, "Hearts"), 
            Card.new(3, "Hearts"), 
            Card.new("K", "Diamonds"), 
            Card.new(4, "Clubs"), 
            Card.new(4, "Spades"), 
            Card.new("J", "Hearts"), 
            Card.new("A", "Diamonds")
        ]

        expected_cards = [
            Card.new(4, "Hearts"), 
            Card.new(4, "Spades"),
            Card.new(4, "Clubs")
        ]

        expectedA = Hand.new(type: :three_kind, cards: expected_cards, kickers: [Card.new("A", "Diamonds")])
        expectedB = Hand.new(type: :three_kind, cards: expected_cards, kickers: [Card.new("A", "Diamonds"), Card.new("K", "Diamonds")])

        handA = mock_class.identify(cardsA)
        handB = mock_class.identify(cardsB)

        expect(handA).to eq(expectedA)
        expect(handB).to eq(expectedB)
    end

    it 'can identify a Straight' do
        cardsA = [
            Card.new(7, "Diamonds"),
            Card.new(5, "Spades"),
            Card.new(6, "Clubs"),
            Card.new(4, "Hearts"), 
            Card.new(8, "Clubs")
        ]

        cardsB = [
            Card.new(7, "Diamonds"), 
            Card.new(8, "Clubs"), 
            Card.new("J", "Hearts"), 
            Card.new(5, "Spades"), 
            Card.new(4, "Hearts"), 
            Card.new(6, "Clubs"), 
            Card.new("A", "Diamonds")
        ]

        expected_cards = [
            Card.new(4, "Hearts"), 
            Card.new(5, "Spades"),
            Card.new(6, "Clubs"),
            Card.new(7, "Diamonds"),
            Card.new(8, "Clubs")
        ]

        expected = Hand.new(type: :straight, cards: expected_cards)

        handA = mock_class.identify(cardsA)
        handB = mock_class.identify(cardsB)

        expect(handA).to eq(expected)
        expect(handB).to eq(expected)
    end

    it 'can identify a Flush' do
        cardsA = [
            Card.new(4, "Hearts"), 
            Card.new(5, "Hearts"),
            Card.new("A", "Hearts"),
            Card.new(7, "Hearts"),
            Card.new("J", "Hearts")
        ]

        cardsB = [
            Card.new(2, "Hearts"),
            Card.new(8, "Clubs"), 
            Card.new(5, "Hearts"),
            Card.new(4, "Hearts"), 
            Card.new("A", "Hearts"),
            Card.new("J", "Hearts"), 
            Card.new(7, "Hearts")
        ]

        expected_cards = [
            Card.new("A", "Hearts"), 
            Card.new("J", "Hearts"),
            Card.new(7, "Hearts"),
            Card.new(5, "Hearts"),
            Card.new(4, "Hearts")
        ]

        expected = Hand.new(type: :flush, cards: expected_cards)

        handA = mock_class.identify(cardsA)
        handB = mock_class.identify(cardsB)

        expect(handA).to eq(expected)
        expect(handB).to eq(expected)
    end

    it 'can identify a Full House' do
        cardsA = [
            Card.new(4, "Hearts"), 
            Card.new("A", "Hearts"),
            Card.new(4, "Diamonds"),
            Card.new("A", "Clubs"),
            Card.new(4, "Spades")
        ]

        cardsB = [
            Card.new(4, "Spades"),
            Card.new(8, "Clubs"), 
            Card.new("A", "Clubs"),
            Card.new(4, "Hearts"), 
            Card.new("A", "Hearts"),
            Card.new(4, "Diamonds"),
            Card.new(7, "Hearts")
        ]

        expected_cards = [
            Card.new(4, "Hearts"), 
            Card.new(4, "Diamonds"),
            Card.new(4, "Spades"),
            Card.new("A", "Hearts"),
            Card.new("A", "Clubs")
        ]

        expected = Hand.new(type: :full_house, cards: expected_cards)

        handA = mock_class.identify(cardsA)
        handB = mock_class.identify(cardsB)

        expect(handA).to eq(expected)
        expect(handB).to eq(expected)
    end

    it 'can identify a Four new a Kind' do
        cardsA = [
            Card.new(4, "Hearts"), 
            Card.new(4, "Clubs"),
            Card.new(4, "Diamonds"),
            Card.new("A", "Clubs"),
            Card.new(4, "Spades")
        ]

        cardsB = [
            Card.new(4, "Spades"),
            Card.new(8, "Clubs"), 
            Card.new(4, "Hearts"), 
            Card.new("A", "Clubs"),
            Card.new(4, "Clubs"),
            Card.new(7, "Hearts"),
            Card.new(4, "Diamonds"),
        ]

        expected_cards = [
            Card.new(4, "Hearts"), 
            Card.new(4, "Clubs"),
            Card.new(4, "Diamonds"),
            Card.new(4, "Spades")
        ]

        expected = Hand.new(type: :four_kind, cards: expected_cards, kickers: [Card.new("A", "Clubs")])

        handA = mock_class.identify(cardsA)
        handB = mock_class.identify(cardsB)

        expect(handA).to eq(expected)
        expect(handB).to eq(expected)
    end

    it 'can identify a Straight Flush' do
        cardsA = [
            Card.new(4, "Spades"), 
            Card.new(6, "Spades"),
            Card.new(5, "Spades"),
            Card.new(8, "Spades"),
            Card.new(7, "Spades")
        ]

        cardsB = [
            Card.new(4, "Spades"),
            Card.new(8, "Clubs"), 
            Card.new(5, "Spades"),
            Card.new(7, "Spades"),
            Card.new(4, "Clubs"),
            Card.new(6, "Spades"),
            Card.new(8, "Spades"),
        ]

        expected_cards = [
            Card.new(4, "Spades"), 
            Card.new(5, "Spades"),
            Card.new(6, "Spades"),
            Card.new(7, "Spades"),
            Card.new(8, "Spades"),
        ]
        
        expected = Hand.new(type: :straight_flush, cards: expected_cards)

        handA = mock_class.identify(cardsA)
        handB = mock_class.identify(cardsB)
        
        expect(handA).to eq(expected)
        expect(handB).to eq(expected)
    end

    it 'can identify a Royal Flush' do
        cardsA = [
            Card.new(10, "Spades"), 
            Card.new("A", "Spades"),
            Card.new("J", "Spades"),
            Card.new("K", "Spades"),
            Card.new("Q", "Spades")
        ]

        cardsB = [
            Card.new(10, "Spades"), 
            Card.new("K", "Spades"),
            Card.new(5, "Diamonds"),
            Card.new("J", "Spades"),
            Card.new("Q", "Spades"),
            Card.new(6, "Clubs"),
            Card.new("A", "Spades"),
        ]

        expected_cards = [
            Card.new(10, "Spades"), 
            Card.new("J", "Spades"),
            Card.new("Q", "Spades"),
            Card.new("K", "Spades"),
            Card.new("A", "Spades")
        ]

        expected = Hand.new(type: :royal_flush, cards: expected_cards)

        handA = mock_class.identify(cardsA)
        handB = mock_class.identify(cardsB)

        expect(handA).to eq(expected)
        expect(handB).to eq(expected)
    end
end