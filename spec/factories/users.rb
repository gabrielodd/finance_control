FactoryGirl.define do
  factory :user do
    email { "user#{SecureRandom.hex(4)}@example.com" }
    admin { false }
    password { "asjf93458f" }
  end
end
