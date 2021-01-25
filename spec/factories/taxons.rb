FactoryBot.define do
  factory :taxon do
    association :taxonomy
    name { Faker::Company.buzzword }

    trait :with_descendants do
      transient do
        generations { 1 }
        amount { 3 }
      end

      after(:create) do |taxon, evaluator|
        if evaluator.generations.positive?
          evaluator.amount.times do
            create(:taxon, :with_descendants,
                   parent: taxon,
                   generations: evaluator.generations - 1,
                   amount: evaluator.amount)
          end
        end
      end
    end
  end
end
