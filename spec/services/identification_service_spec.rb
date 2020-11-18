require 'rails_helper'


describe IdentificationService, '#identify' do

    let(:mock_class) {Class.new { extend IdentificationService } }

    it 'can identify a Pair' do
        cards1 = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::FOUR, Suit::CLUBS)
        ]

        cards2 = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::THREE, Suit::HEARTS), 
            Card.new(Rank::KING, Suit::DIAMONDS), 
            Card.new(Rank::FOUR, Suit::CLUBS), 
            Card.new(Rank::ACE, Suit::SPADES), 
            Card.new(Rank::JACK, Suit::HEARTS), 
            Card.new(Rank::TWO, Suit::CLUBS)
        ]

        hand_cards = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::FOUR, Suit::CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand::PAIR, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Two Pair' do
        cards1 = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::ACE, Suit::SPADES),
            Card.new(Rank::FOUR, Suit::CLUBS),
            Card.new(Rank::ACE, Suit::DIAMONDS), 
        ]

        cards2 = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::THREE, Suit::HEARTS), 
            Card.new(Rank::KING, Suit::DIAMONDS), 
            Card.new(Rank::FOUR, Suit::CLUBS), 
            Card.new(Rank::ACE, Suit::SPADES), 
            Card.new(Rank::JACK, Suit::HEARTS), 
            Card.new(Rank::ACE, Suit::DIAMONDS)
        ]

        hand_cards = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::FOUR, Suit::CLUBS),
            Card.new(Rank::ACE, Suit::SPADES),
            Card.new(Rank::ACE, Suit::DIAMONDS), 
        ]

        hand = Hand.new(metahand: MetaHand::TWO_PAIR, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Three of a Kind' do
        cards1 = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::FOUR, Suit::SPADES),
            Card.new(Rank::FOUR, Suit::CLUBS)
        ]

        cards2 = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::THREE, Suit::HEARTS), 
            Card.new(Rank::KING, Suit::DIAMONDS), 
            Card.new(Rank::FOUR, Suit::CLUBS), 
            Card.new(Rank::FOUR, Suit::SPADES), 
            Card.new(Rank::JACK, Suit::HEARTS), 
            Card.new(Rank::ACE, Suit::DIAMONDS)
        ]

        hand_cards = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::FOUR, Suit::SPADES),
            Card.new(Rank::FOUR, Suit::CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand::THREE_KIND, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Straight' do
        cards1 = [
            Card.new(Rank::SEVEN, Suit::DIAMONDS),
            Card.new(Rank::FIVE, Suit::SPADES),
            Card.new(Rank::SIX, Suit::CLUBS),
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::EIGHT, Suit::CLUBS)
        ]

        cards2 = [
            Card.new(Rank::SEVEN, Suit::DIAMONDS), 
            Card.new(Rank::EIGHT, Suit::CLUBS), 
            Card.new(Rank::FIVE, Suit::SPADES), 
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::SIX, Suit::CLUBS), 
            Card.new(Rank::JACK, Suit::HEARTS), 
            Card.new(Rank::ACE, Suit::DIAMONDS)
        ]

        hand_cards = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::FIVE, Suit::SPADES),
            Card.new(Rank::SIX, Suit::CLUBS),
            Card.new(Rank::SEVEN, Suit::DIAMONDS),
            Card.new(Rank::EIGHT, Suit::CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand::STRAIGHT, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify two straights' do
        community = [
        Card.new(rank: Rank::TEN, suit: Suit::HEARTS),
        Card.new(rank: Rank::THREE, suit: Suit::DIAMONDS),
        Card.new(rank: Rank::EIGHT, suit: Suit::SPADES),
        Card.new(rank: Rank::TWO, suit: Suit::DIAMONDS),
        Card.new(rank: Rank::NINE, suit: Suit::HEARTS),
        ]

        # player1 = [Card.new(rank: Rank::QUEEN, Sui)]

        # Straight 
        #  ["queen of clubs", "jack of hearts", "king of hearts", "three of spades"]
        
        #  Francene - 
        #  Straight 
        #  ["queen of hearts", "jack of spades", "king of clubs", "nine of spades"]

    end

    it 'can identify a Flush' do
        cards1 = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::FIVE, Suit::HEARTS),
            Card.new(Rank::ACE, Suit::HEARTS),
            Card.new(Rank::SEVEN, Suit::HEARTS),
            Card.new(Rank::JACK, Suit::HEARTS)
        ]

        cards2 = [
            Card.new(Rank::TWO, Suit::HEARTS),
            Card.new(Rank::EIGHT, Suit::CLUBS), 
            Card.new(Rank::FIVE, Suit::HEARTS),
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::ACE, Suit::HEARTS),
            Card.new(Rank::JACK, Suit::HEARTS), 
            Card.new(Rank::SEVEN, Suit::HEARTS)
        ]

        hand_cards = [
            Card.new(Rank::ACE, Suit::HEARTS), 
            Card.new(Rank::JACK, Suit::HEARTS),
            Card.new(Rank::SEVEN, Suit::HEARTS),
            Card.new(Rank::FIVE, Suit::HEARTS),
            Card.new(Rank::FOUR, Suit::HEARTS)
        ]

        hand = Hand.new(metahand: MetaHand::FLUSH, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Full House' do
        cards1 = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::ACE, Suit::HEARTS),
            Card.new(Rank::FOUR, Suit::DIAMONDS),
            Card.new(Rank::ACE, Suit::CLUBS),
            Card.new(Rank::FOUR, Suit::SPADES)
        ]

        cards2 = [
            Card.new(Rank::FOUR, Suit::SPADES),
            Card.new(Rank::EIGHT, Suit::CLUBS), 
            Card.new(Rank::ACE, Suit::CLUBS),
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::ACE, Suit::HEARTS),
            Card.new(Rank::FOUR, Suit::DIAMONDS),
            Card.new(Rank::SEVEN, Suit::HEARTS)
        ]

        hand_cards = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::FOUR, Suit::DIAMONDS),
            Card.new(Rank::FOUR, Suit::SPADES),
            Card.new(Rank::ACE, Suit::HEARTS),
            Card.new(Rank::ACE, Suit::CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand::FULL_HOUSE, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Four of a Kind' do
        cards1 = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::FOUR, Suit::CLUBS),
            Card.new(Rank::FOUR, Suit::DIAMONDS),
            Card.new(Rank::FOUR, Suit::SPADES)
        ]

        cards2 = [
            Card.new(Rank::FOUR, Suit::SPADES),
            Card.new(Rank::EIGHT, Suit::CLUBS), 
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::ACE, Suit::CLUBS),
            Card.new(Rank::FOUR, Suit::CLUBS),
            Card.new(Rank::SEVEN, Suit::HEARTS),
            Card.new(Rank::FOUR, Suit::DIAMONDS),
        ]

        hand_cards = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::FOUR, Suit::DIAMONDS),
            Card.new(Rank::FOUR, Suit::SPADES),
            Card.new(Rank::FOUR, Suit::CLUBS)
        ]

        hand = Hand.new(metahand: MetaHand::FOUR_KIND, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Straight Flush' do
        cards1 = [
            Card.new(Rank::FOUR, Suit::SPADES), 
            Card.new(Rank::SIX, Suit::SPADES),
            Card.new(Rank::FIVE, Suit::SPADES),
            Card.new(Rank::EIGHT, Suit::SPADES),
            Card.new(Rank::SEVEN, Suit::SPADES)
        ]

        cards2 = [
            Card.new(Rank::FOUR, Suit::SPADES),
            Card.new(Rank::EIGHT, Suit::CLUBS), 
            Card.new(Rank::FIVE, Suit::SPADES),
            Card.new(Rank::SEVEN, Suit::SPADES),
            Card.new(Rank::FOUR, Suit::CLUBS),
            Card.new(Rank::SIX, Suit::SPADES),
            Card.new(Rank::EIGHT, Suit::SPADES),
        ]

        hand_cards = [
            Card.new(Rank::FOUR, Suit::SPADES), 
            Card.new(Rank::FIVE, Suit::SPADES),
            Card.new(Rank::SIX, Suit::SPADES),
            Card.new(Rank::SEVEN, Suit::SPADES),
            Card.new(Rank::EIGHT, Suit::SPADES),
        ]
        
        hand = Hand.new(metahand: MetaHand::STRAIGHT_FLUSH, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)
        
        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end

    it 'can identify a Royal Flush' do
        cards1 = [
            Card.new(Rank::TEN, Suit::SPADES), 
            Card.new(Rank::ACE, Suit::SPADES),
            Card.new(Rank::JACK, Suit::SPADES),
            Card.new(Rank::KING, Suit::SPADES),
            Card.new(Rank::QUEEN, Suit::SPADES)
        ]

        cards2 = [
            Card.new(Rank::TEN, Suit::SPADES), 
            Card.new(Rank::KING, Suit::SPADES),
            Card.new(Rank::FIVE, Suit::DIAMONDS),
            Card.new(Rank::JACK, Suit::SPADES),
            Card.new(Rank::QUEEN, Suit::SPADES),
            Card.new(Rank::SIX, Suit::CLUBS),
            Card.new(Rank::ACE, Suit::SPADES),
        ]

        hand_cards = [
            Card.new(Rank::TEN, Suit::SPADES), 
            Card.new(Rank::JACK, Suit::SPADES),
            Card.new(Rank::QUEEN, Suit::SPADES),
            Card.new(Rank::KING, Suit::SPADES),
            Card.new(Rank::ACE, Suit::SPADES)
        ]

        hand = Hand.new(metahand: MetaHand::ROYAL_FLUSH, cards: hand_cards)

        hand1 = mock_class.identify(cards1)
        hand2 = mock_class.identify(cards2)

        expect(hand1).to eq(hand)
        expect(hand2).to eq(hand)
    end
end