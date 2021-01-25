FactoryBot.define do
  factory :taxonomy do
    association :organization
    name { Faker::Company.industry }
  end
end
