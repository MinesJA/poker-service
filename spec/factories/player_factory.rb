FactoryBot.define do
    factory :player do
        initialize_with{ new(name: Faker::Name.name)}
    end
end