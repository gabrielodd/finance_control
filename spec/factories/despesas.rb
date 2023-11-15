FactoryGirl.define do
  factory :despesa do
    date { Date.today }
    valor { 100.0 }
    repeating { false }
    association :categoria
    association :user

    trait :repeating do
      repeating { true }
    end
  end
end