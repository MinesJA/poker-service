FactoryBot.define do
    factory :hand do
        type { :pair}
        cards { [build(:card, rank: 2, suit: "Clubs"), build(:card, rank: 2, suit: "Diamonds")] }
        kicker { [[build(:card, rank: 6, suit: "Hearts"), build(:card, rank: 4, suit: "Clubs"), build(:card, rank: "A", suit: "Hearts")]] }

        transient do
            amount {5}
            card_ranks {((2..10).to_a + %w(J Q K A))}
            card_suits {%w(Hearts Diamonds Clubs Spades)}
            random_cards {(0..(card_ranks.size * card_suits.size)).to_a.sample(amount).map{|x|
                r_i = (x/4.5).round()
                s_i = (x/17).round()
                build(:card, rank: card_ranks[r_i], suit: card_suits[s_i])
            }}
        end

        # trait :with_random_cards do
        #     transient do
        #         amount {5}
        #         card_ranks {((2..10).to_a + %w(J Q K A))}
        #         card_suits {%w(Hearts Diamonds Clubs Spades)}
        #         random_cards {(0..(card_ranks.size * card_suits.size)).to_a.sample(amount).map{|x|
        #             r_i = (x/4.5).round()
        #             s_i = (x/17).round()
        #             build(:card, rank: card_ranks[r_i], suit: card_suits[s_i])
        #         }}
        #     end

        #     cards {random_cards(amount)}
        # end

        # trait :with_kicker_count do
        #     transient do
        #         amount {2}
        #     end

        #     kickers {random_cards(amount)}
        # end

        # factory :with_kickers, traits [:with_kicker_count]
        # factory :without_kickers, traits [:with_card_count]
    end


end



