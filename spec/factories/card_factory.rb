FactoryBot.define do
    factory :card do
        transient do
            suit_name
            rank_name
        end

        suit { Suit::ALL.find{|suit| suit.name == suit_name}}
        rank {Rank::ALL.find{|rank| rank.name == rank_name}}
    end


end