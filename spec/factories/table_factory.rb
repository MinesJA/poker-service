FactoryBot.define do
    factory :table do
        player_count {5}
        initialize_with{new(players: (0..player_count).map{|i| build(:player)})}
    end
end