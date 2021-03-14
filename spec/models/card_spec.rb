require 'rails_helper'

describe Card, '.new' do
    it 'creates a new card with a rank and suit' do
        card = Card.new(10, "Clubs")
        
        expect(card).to be_instance_of(Card)

        expect(card.rank).to be_eql(10)
        expect(card.suit).to be_eql("Clubs")
    end    

    it 'raises an error with an invalid rank or suit' do
        expect{Card.new(1, "Clubs")}.to raise_error("Invalid rank")
        expect{Card.new(2, "Foo")}.to raise_error("Invalid suit")
    end
end

describe Card, '#eql?' do
    it 'is equal with equal rank and suit' do
        cardA = Card.new(10, "Clubs")
        cardB = Card.new(10, "Clubs")

        cardC = Card.new(9, "Clubs")

        expect(cardA).to be_eql(cardB)
        expect(cardA).to_not be_eql(cardC)
    end
end

describe Card, '#score' do
    it 'returns a cards rank score' do
        card = Card.new(2, "D")
        expect(card.score).to be_eql(1)
    end
end

describe Card, '#<=>' do
    it 'can be compared by rank' do

        # TODO: need a test where we can test for
        # actual integer returned: -1, 0, 1
    end

    it 'can be sorted by rank' do
        cards = [Card.new(2, "Clubs"),
                Card.new(6, "Spades"),    
                Card.new(2, "Diamonds"),
                Card.new(5, "Spades")]

        expected = [Card.new(2, "Clubs"),
                    Card.new(2, "Diamonds"),
                    Card.new(5, "Spades"),
                    Card.new(6, "Spades")]

        expect(cards.sort).to contain_exactly(expected)
    end
end

describe Card, '.from_str' do
    it 'creates a card from the short name of card' do
        card = Card.from_str("KD")
        expected Card.new("K", "Diamonds")

        expect(card).to be(expected)

        card2 = Card.from_str("2H")
        expected2 Card.new(2, "Hearts")
        
        expect(card2).to be(expected2)
    end
end