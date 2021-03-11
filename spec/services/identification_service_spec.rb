require 'rails_helper'


describe IdentificationService, '#identify' do

    let(:mock_class) {Class.new { extend IdentificationService } }

    it 'can identify a Pair' do
        cards1 = [
            Card.new(4, "Hearts"), 
            Card.new(4, "Clubs"),
            Card.new("A", "Spades"), 
        ]

        cards2 = [
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

        expected = Hand.new(type: :pair , cards: expected_cards, kicker: Card.new("A", "Spades"))

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(expected)
        expect(hand2).to eq(expected)
    end

    it 'can identify a Two Pair' do
        cards1 = [
            Card.new(4, "Hearts"), 
            Card.new("A", "Spades"),
            Card.new(4, "Clubs"),
            Card.new("A", "Diamonds"),
            Card.new("K", "Diamonds"),
        ]

        cards2 = [
            Card.new(4, "Hearts"), 
            Card.new(3, "Hearts"), 
            Card.new("K", "Diamonds"), 
            Card.new(4, "Clubs"), 
            Card.new("A", "Spades"), 
            Card.new("J", "Hearts"), 
            Card.new("A", "Diamonds")
        ]

        expected_cards = [
            Card.new(4, "Hearts"), 
            Card.new(4, "Clubs"),
            Card.new("A", "Spades"),
            Card.new("A", "Diamonds"), 
        ]

        expected = Hand.new(type: :two_pair, cards: expected_cards, kicker: Card.new("K", "Diamonds"))

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(expected)
        expect(hand2).to eq(expected)
    end

    it 'can identify a Three new a Kind' do
        cards1 = [
            Card.new(4, "Hearts"), 
            Card.new(4, "Spades"),
            Card.new(4, "Clubs"),
            Card.new("A", "Diamonds")
        ]

        cards2 = [
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

        expected = Hand.new(type: :three_kind, cards: expected_cards, kicker: Card.new("A", "Diamonds"))

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(expected)
        expect(hand2).to eq(expected)
    end

    it 'can identify a Straight' do
        cards1 = [
            Card.new(7, "Diamonds"),
            Card.new(5, "Spades"),
            Card.new(6, "Clubs"),
            Card.new(4, "Hearts"), 
            Card.new(8, "Clubs")
        ]

        cards2 = [
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

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(expected)
        expect(hand2).to eq(expected)
    end

    it 'can identify a Flush' do
        cards1 = [
            Card.new(4, "Hearts"), 
            Card.new(5, "Hearts"),
            Card.new("A", "Hearts"),
            Card.new(7, "Hearts"),
            Card.new("J", "Hearts")
        ]

        cards2 = [
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

        expected = Hand.new(type: type.new(:FLUSH), cards: expected_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(expected)
        expect(hand2).to eq(expected)
    end

    it 'can identify a Full House' do
        cards1 = [
            Card.new(4, "Hearts"), 
            Card.new("A", "Hearts"),
            Card.new(4, "Diamonds"),
            Card.new("A", "Clubs"),
            Card.new(4, "Spades")
        ]

        cards2 = [
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

        expected = Hand.new(type: type.new(:FULL_HOUSE), cards: expected_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(expected)
        expect(hand2).to eq(expected)
    end

    it 'can identify a Four new a Kind' do
        cards1 = [
            Card.new(4, "Hearts"), 
            Card.new(4, "Clubs"),
            Card.new(4, "Diamonds"),
            Card.new("A", "Clubs"),
            Card.new(4, "Spades")
        ]

        cards2 = [
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
            Card.new(4, "Diamonds"),
            Card.new(4, "Spades"),
            Card.new(4, "Clubs")
        ]

        expected = Hand.new(type: :four_kind, cards: expected_cards, kicker: Card.new("A", "Clubs"))

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(expected)
        expect(hand2).to eq(expected)
    end

    it 'can identify a Straight Flush' do
        cards1 = [
            Card.new(4, "Spades"), 
            Card.new(6, "Spades"),
            Card.new(5, "Spades"),
            Card.new(8, "Spades"),
            Card.new(7, "Spades")
        ]

        cards2 = [
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

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)
        
        expect(hand1).to eq(expected)
        expect(hand2).to eq(expected)
    end

    it 'can identify a Royal Flush' do
        cards1 = [
            Card.new(10, "Spades"), 
            Card.new("A", "Spades"),
            Card.new("J", "Spades"),
            Card.new("K", "Spades"),
            Card.new("Q", "Spades")
        ]

        cards2 = [
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

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(expected)
        expect(hand2).to eq(expected)
    end
end