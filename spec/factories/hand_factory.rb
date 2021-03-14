FactoryBot.define do
    factory :hand do
        
        type { :straight }

        def random_cards(x)
            card_ranks = ((2..10).to_a + %w(J Q K A))
            card_suits = %w(Hearts Diamonds Clubs Spades)

            return (0..52).to_a.sample(5).map{|x|
                r_i = (x/4.5).round()
                s_i = (x/17).round()
                build(:card, rank: card_ranks[r_i], suit: card_suits[s_i])
            }
        end

        trait :with_card_count do
            transient do
                amount {5}    
            end

            cards {random_cards(amount)}
        end

        trait :with_kicker_count do
            transient do
                amount {2}
            end

            kickers {random_cards(amount)}
        end

        
        cards {random_cards(5)}
        kickers {[]}

        # factory :with_kickers, traits [:with_kicker_count]
        # factory :without_kickers, traits [:with_card_count]
    end


end



