require 'rails_helper'

describe IdentificationService, '#identify' do
    it 'identify pair' do 
        identService = IdentificationService.new()

        hand = [Card.new(Rank::FOUR, Suit::HEARTS), Card.new(Rank::TWO, Suit::HEARTS), Card.new(Rank::TWO, Suit::CLUBS)]

        metahands = identService.identify(hand)
        
        expect(metahands.count).to eq(1)
        expect(metahands.first).to be_eql(MetaHand::TWO_PAIR)
    end

    it 'identify pair, three of a kind, and full house' do
        identService = IdentificationService.new()

        hand = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::TWO, Suit::CLUBS),
            Card.new(Rank::FOUR, Suit::DIAMONDS),
            Card.new(Rank::TWO, Suit::HEARTS), 
            Card.new(Rank::FOUR, Suit::SPADES)   
        ]

        metahands = identService.identify(hand)
        
        # expect(metahands.count).to eq(3)
        expect(metahands).to include(MetaHand::PAIR)
        expect(metahands).to include(MetaHand::THREE_KIND)
        expect(metahands).to include(MetaHand::FULL_HOUSE)
    end

    it 'identify two pair' do
        identService = IdentificationService.new()

        hand = [
            Card.new(Rank::FOUR, Suit::HEARTS), 
            Card.new(Rank::TWO, Suit::CLUBS),
            Card.new(Rank::TWO, Suit::HEARTS), 
            Card.new(Rank::FOUR, Suit::SPADES)   
        ]

        metahands = identService.identify(hand)
        
        # expect(metahands.count).to eq(3)
        expect(metahands).to include(MetaHand::PAIR)
        expect(metahands).to include(MetaHand::THREE_KIND)
        expect(metahands).to include(MetaHand::FULL_HOUSE)
    end
end