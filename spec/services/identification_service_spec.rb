require 'rails_helper'


describe IdentificationService, '#identify' do

    let(:mock_class) {Class.new { extend IdentificationService } }

    it 'can identify a Pair' do
        cards1 = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS)
        ]

        cards2 = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::THREE, suit: Suit::HEARTS), 
            Card.new(rank: Rank::KING, suit: Suit::DIAMONDS), 
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS), 
            Card.new(rank: Rank::ACE, suit: Suit::SPADES), 
            Card.new(rank: Rank::JACK, suit: Suit::HEARTS), 
            Card.new(rank: Rank::TWO, suit: Suit::CLUBS)
        ]

        hand_cards = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand::PAIR, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Two Pair' do
        cards1 = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::ACE, suit: Suit::SPADES),
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS),
            Card.new(rank: Rank::ACE, suit: Suit::DIAMONDS), 
        ]

        cards2 = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::THREE, suit: Suit::HEARTS), 
            Card.new(rank: Rank::KING, suit: Suit::DIAMONDS), 
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS), 
            Card.new(rank: Rank::ACE, suit: Suit::SPADES), 
            Card.new(rank: Rank::JACK, suit: Suit::HEARTS), 
            Card.new(rank: Rank::ACE, suit: Suit::DIAMONDS)
        ]

        hand_cards = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS),
            Card.new(rank: Rank::ACE, suit: Suit::SPADES),
            Card.new(rank: Rank::ACE, suit: Suit::DIAMONDS), 
        ]

        hand = Hand.new(metahand: MetaHand::TWO_PAIR, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Three of a Kind' do
        cards1 = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::FOUR, suit: Suit::SPADES),
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS)
        ]

        cards2 = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::THREE, suit: Suit::HEARTS), 
            Card.new(rank: Rank::KING, suit: Suit::DIAMONDS), 
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS), 
            Card.new(rank: Rank::FOUR, suit: Suit::SPADES), 
            Card.new(rank: Rank::JACK, suit: Suit::HEARTS), 
            Card.new(rank: Rank::ACE, suit: Suit::DIAMONDS)
        ]

        hand_cards = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::FOUR, suit: Suit::SPADES),
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand::THREE_KIND, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Straight' do
        cards1 = [
            Card.new(rank: Rank::SEVEN, suit: Suit::DIAMONDS),
            Card.new(rank: Rank::FIVE, suit: Suit::SPADES),
            Card.new(rank: Rank::SIX, suit: Suit::CLUBS),
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::EIGHT, suit: Suit::CLUBS)
        ]

        cards2 = [
            Card.new(rank: Rank::SEVEN, suit: Suit::DIAMONDS), 
            Card.new(rank: Rank::EIGHT, suit: Suit::CLUBS), 
            Card.new(rank: Rank::FIVE, suit: Suit::SPADES), 
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::SIX, suit: Suit::CLUBS), 
            Card.new(rank: Rank::JACK, suit: Suit::HEARTS), 
            Card.new(rank: Rank::ACE, suit: Suit::DIAMONDS)
        ]

        hand_cards = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::FIVE, suit: Suit::SPADES),
            Card.new(rank: Rank::SIX, suit: Suit::CLUBS),
            Card.new(rank: Rank::SEVEN, suit: Suit::DIAMONDS),
            Card.new(rank: Rank::EIGHT, suit: Suit::CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand::STRAIGHT, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Flush' do
        cards1 = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::FIVE, suit: Suit::HEARTS),
            Card.new(rank: Rank::ACE, suit: Suit::HEARTS),
            Card.new(rank: Rank::SEVEN, suit: Suit::HEARTS),
            Card.new(rank: Rank::JACK, suit: Suit::HEARTS)
        ]

        cards2 = [
            Card.new(rank: Rank::TWO, suit: Suit::HEARTS),
            Card.new(rank: Rank::EIGHT, suit: Suit::CLUBS), 
            Card.new(rank: Rank::FIVE, suit: Suit::HEARTS),
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::ACE, suit: Suit::HEARTS),
            Card.new(rank: Rank::JACK, suit: Suit::HEARTS), 
            Card.new(rank: Rank::SEVEN, suit: Suit::HEARTS)
        ]

        hand_cards = [
            Card.new(rank: Rank::ACE, suit: Suit::HEARTS), 
            Card.new(rank: Rank::JACK, suit: Suit::HEARTS),
            Card.new(rank: Rank::SEVEN, suit: Suit::HEARTS),
            Card.new(rank: Rank::FIVE, suit: Suit::HEARTS),
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS)
        ]

        hand = Hand.new(metahand: MetaHand::FLUSH, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Full House' do
        cards1 = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::ACE, suit: Suit::HEARTS),
            Card.new(rank: Rank::FOUR, suit: Suit::DIAMONDS),
            Card.new(rank: Rank::ACE, suit: Suit::CLUBS),
            Card.new(rank: Rank::FOUR, suit: Suit::SPADES)
        ]

        cards2 = [
            Card.new(rank: Rank::FOUR, suit: Suit::SPADES),
            Card.new(rank: Rank::EIGHT, suit: Suit::CLUBS), 
            Card.new(rank: Rank::ACE, suit: Suit::CLUBS),
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::ACE, suit: Suit::HEARTS),
            Card.new(rank: Rank::FOUR, suit: Suit::DIAMONDS),
            Card.new(rank: Rank::SEVEN, suit: Suit::HEARTS)
        ]

        hand_cards = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::FOUR, suit: Suit::DIAMONDS),
            Card.new(rank: Rank::FOUR, suit: Suit::SPADES),
            Card.new(rank: Rank::ACE, suit: Suit::HEARTS),
            Card.new(rank: Rank::ACE, suit: Suit::CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand::FULL_HOUSE, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Four of a Kind' do
        cards1 = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS),
            Card.new(rank: Rank::FOUR, suit: Suit::DIAMONDS),
            Card.new(rank: Rank::FOUR, suit: Suit::SPADES)
        ]

        cards2 = [
            Card.new(rank: Rank::FOUR, suit: Suit::SPADES),
            Card.new(rank: Rank::EIGHT, suit: Suit::CLUBS), 
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::ACE, suit: Suit::CLUBS),
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS),
            Card.new(rank: Rank::SEVEN, suit: Suit::HEARTS),
            Card.new(rank: Rank::FOUR, suit: Suit::DIAMONDS),
        ]

        hand_cards = [
            Card.new(rank: Rank::FOUR, suit: Suit::HEARTS), 
            Card.new(rank: Rank::FOUR, suit: Suit::DIAMONDS),
            Card.new(rank: Rank::FOUR, suit: Suit::SPADES),
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand::FOUR_KIND, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Straight Flush' do
        cards1 = [
            Card.new(rank: Rank::FOUR, suit: Suit::SPADES), 
            Card.new(rank: Rank::SIX, suit: Suit::SPADES),
            Card.new(rank: Rank::FIVE, suit: Suit::SPADES),
            Card.new(rank: Rank::EIGHT, suit: Suit::SPADES),
            Card.new(rank: Rank::SEVEN, suit: Suit::SPADES)
        ]

        cards2 = [
            Card.new(rank: Rank::FOUR, suit: Suit::SPADES),
            Card.new(rank: Rank::EIGHT, suit: Suit::CLUBS), 
            Card.new(rank: Rank::FIVE, suit: Suit::SPADES),
            Card.new(rank: Rank::SEVEN, suit: Suit::SPADES),
            Card.new(rank: Rank::FOUR, suit: Suit::CLUBS),
            Card.new(rank: Rank::SIX, suit: Suit::SPADES),
            Card.new(rank: Rank::EIGHT, suit: Suit::SPADES),
        ]

        hand_cards = [
            Card.new(rank: Rank::FOUR, suit: Suit::SPADES), 
            Card.new(rank: Rank::FIVE, suit: Suit::SPADES),
            Card.new(rank: Rank::SIX, suit: Suit::SPADES),
            Card.new(rank: Rank::SEVEN, suit: Suit::SPADES),
            Card.new(rank: Rank::EIGHT, suit: Suit::SPADES),
        ]
        
        hand = Hand.new(metahand: MetaHand::STRAIGHT_FLUSH, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)
        
        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Royal Flush' do
        cards1 = [
            Card.new(rank: Rank::TEN, suit: Suit::SPADES), 
            Card.new(rank: Rank::ACE, suit: Suit::SPADES),
            Card.new(rank: Rank::JACK, suit: Suit::SPADES),
            Card.new(rank: Rank::KING, suit: Suit::SPADES),
            Card.new(rank: Rank::QUEEN, suit: Suit::SPADES)
        ]

        cards2 = [
            Card.new(rank: Rank::TEN, suit: Suit::SPADES), 
            Card.new(rank: Rank::KING, suit: Suit::SPADES),
            Card.new(rank: Rank::FIVE, suit: Suit::DIAMONDS),
            Card.new(rank: Rank::JACK, suit: Suit::SPADES),
            Card.new(rank: Rank::QUEEN, suit: Suit::SPADES),
            Card.new(rank: Rank::SIX, suit: Suit::CLUBS),
            Card.new(rank: Rank::ACE, suit: Suit::SPADES),
        ]

        hand_cards = [
            Card.new(rank: Rank::TEN, suit: Suit::SPADES), 
            Card.new(rank: Rank::JACK, suit: Suit::SPADES),
            Card.new(rank: Rank::QUEEN, suit: Suit::SPADES),
            Card.new(rank: Rank::KING, suit: Suit::SPADES),
            Card.new(rank: Rank::ACE, suit: Suit::SPADES)
        ]

        hand = Hand.new(metahand: MetaHand::ROYAL_FLUSH, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end
end