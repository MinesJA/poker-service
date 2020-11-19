FactoryBot.define do
    factory :table do
        initialize_with{new(players: (0..5).map{|i| build(:player)})}
    end
end