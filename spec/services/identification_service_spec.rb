require 'rails_helper'


describe IdentificationService, '#identify' do

    let(:mock_class) {Class.new { extend IdentificationService } }

    it 'can identify a Pair' do
        cards1 = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:FOUR, :CLUBS)
        ]

        cards2 = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:THREE, :HEARTS), 
            Card.of(:KING, :DIAMONDS), 
            Card.of(:FOUR, :CLUBS), 
            Card.of(:ACE, :SPADES), 
            Card.of(:JACK, :HEARTS), 
            Card.of(:TWO, :CLUBS)
        ]

        hand_cards = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:FOUR, :CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand.of(:PAIR), cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Two Pair' do
        cards1 = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:ACE, :SPADES),
            Card.of(:FOUR, :CLUBS),
            Card.of(:ACE, :DIAMONDS), 
        ]

        cards2 = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:THREE, :HEARTS), 
            Card.of(:KING, :DIAMONDS), 
            Card.of(:FOUR, :CLUBS), 
            Card.of(:ACE, :SPADES), 
            Card.of(:JACK, :HEARTS), 
            Card.of(:ACE, :DIAMONDS)
        ]

        hand_cards = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:FOUR, :CLUBS),
            Card.of(:ACE, :SPADES),
            Card.of(:ACE, :DIAMONDS), 
        ]

        hand = Hand.new(metahand: MetaHand.of(:TWO_PAIR), cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Three of a Kind' do
        cards1 = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:FOUR, :SPADES),
            Card.of(:FOUR, :CLUBS)
        ]

        cards2 = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:THREE, :HEARTS), 
            Card.of(:KING, :DIAMONDS), 
            Card.of(:FOUR, :CLUBS), 
            Card.of(:FOUR, :SPADES), 
            Card.of(:JACK, :HEARTS), 
            Card.of(:ACE, :DIAMONDS)
        ]

        hand_cards = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:FOUR, :SPADES),
            Card.of(:FOUR, :CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand.of(:THREE_KIND), cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Straight' do
        cards1 = [
            Card.of(:SEVEN, :DIAMONDS),
            Card.of(:FIVE, :SPADES),
            Card.of(:SIX, :CLUBS),
            Card.of(:FOUR, :HEARTS), 
            Card.of(:EIGHT, :CLUBS)
        ]

        cards2 = [
            Card.of(:SEVEN, :DIAMONDS), 
            Card.of(:EIGHT, :CLUBS), 
            Card.of(:FIVE, :SPADES), 
            Card.of(:FOUR, :HEARTS), 
            Card.of(:SIX, :CLUBS), 
            Card.of(:JACK, :HEARTS), 
            Card.of(:ACE, :DIAMONDS)
        ]

        hand_cards = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:FIVE, :SPADES),
            Card.of(:SIX, :CLUBS),
            Card.of(:SEVEN, :DIAMONDS),
            Card.of(:EIGHT, :CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand.of(:STRAIGHT), cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Flush' do
        cards1 = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:FIVE, :HEARTS),
            Card.of(:ACE, :HEARTS),
            Card.of(:SEVEN, :HEARTS),
            Card.of(:JACK, :HEARTS)
        ]

        cards2 = [
            Card.of(:TWO, :HEARTS),
            Card.of(:EIGHT, :CLUBS), 
            Card.of(:FIVE, :HEARTS),
            Card.of(:FOUR, :HEARTS), 
            Card.of(:ACE, :HEARTS),
            Card.of(:JACK, :HEARTS), 
            Card.of(:SEVEN, :HEARTS)
        ]

        hand_cards = [
            Card.of(:ACE, :HEARTS), 
            Card.of(:JACK, :HEARTS),
            Card.of(:SEVEN, :HEARTS),
            Card.of(:FIVE, :HEARTS),
            Card.of(:FOUR, :HEARTS)
        ]

        hand = Hand.new(metahand: MetaHand.of(:FLUSH), cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Full House' do
        cards1 = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:ACE, :HEARTS),
            Card.of(:FOUR, :DIAMONDS),
            Card.of(:ACE, :CLUBS),
            Card.of(:FOUR, :SPADES)
        ]

        cards2 = [
            Card.of(:FOUR, :SPADES),
            Card.of(:EIGHT, :CLUBS), 
            Card.of(:ACE, :CLUBS),
            Card.of(:FOUR, :HEARTS), 
            Card.of(:ACE, :HEARTS),
            Card.of(:FOUR, :DIAMONDS),
            Card.of(:SEVEN, :HEARTS)
        ]

        hand_cards = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:FOUR, :DIAMONDS),
            Card.of(:FOUR, :SPADES),
            Card.of(:ACE, :HEARTS),
            Card.of(:ACE, :CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand.of(:FULL_HOUSE), cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Four of a Kind' do
        cards1 = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:FOUR, :CLUBS),
            Card.of(:FOUR, :DIAMONDS),
            Card.of(:FOUR, :SPADES)
        ]

        cards2 = [
            Card.of(:FOUR, :SPADES),
            Card.of(:EIGHT, :CLUBS), 
            Card.of(:FOUR, :HEARTS), 
            Card.of(:ACE, :CLUBS),
            Card.of(:FOUR, :CLUBS),
            Card.of(:SEVEN, :HEARTS),
            Card.of(:FOUR, :DIAMONDS),
        ]

        hand_cards = [
            Card.of(:FOUR, :HEARTS), 
            Card.of(:FOUR, :DIAMONDS),
            Card.of(:FOUR, :SPADES),
            Card.of(:FOUR, :CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand.of(:FOUR_KIND), cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Straight Flush' do
        cards1 = [
            Card.of(:FOUR, :SPADES), 
            Card.of(:SIX, :SPADES),
            Card.of(:FIVE, :SPADES),
            Card.of(:EIGHT, :SPADES),
            Card.of(:SEVEN, :SPADES)
        ]

        cards2 = [
            Card.of(:FOUR, :SPADES),
            Card.of(:EIGHT, :CLUBS), 
            Card.of(:FIVE, :SPADES),
            Card.of(:SEVEN, :SPADES),
            Card.of(:FOUR, :CLUBS),
            Card.of(:SIX, :SPADES),
            Card.of(:EIGHT, :SPADES),
        ]

        hand_cards = [
            Card.of(:FOUR, :SPADES), 
            Card.of(:FIVE, :SPADES),
            Card.of(:SIX, :SPADES),
            Card.of(:SEVEN, :SPADES),
            Card.of(:EIGHT, :SPADES),
        ]
        
        hand = Hand.new(metahand: MetaHand.of(:STRAIGHT_FLUSH), cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)
        
        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Royal Flush' do
        cards1 = [
            Card.of(:TEN, :SPADES), 
            Card.of(:ACE, :SPADES),
            Card.of(:JACK, :SPADES),
            Card.of(:KING, :SPADES),
            Card.of(:QUEEN, :SPADES)
        ]

        cards2 = [
            Card.of(:TEN, :SPADES), 
            Card.of(:KING, :SPADES),
            Card.of(:FIVE, :DIAMONDS),
            Card.of(:JACK, :SPADES),
            Card.of(:QUEEN, :SPADES),
            Card.of(:SIX, :CLUBS),
            Card.of(:ACE, :SPADES),
        ]

        hand_cards = [
            Card.of(:TEN, :SPADES), 
            Card.of(:JACK, :SPADES),
            Card.of(:QUEEN, :SPADES),
            Card.of(:KING, :SPADES),
            Card.of(:ACE, :SPADES)
        ]

        hand = Hand.new(metahand: MetaHand.of(:ROYAL_FLUSH), cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end
end