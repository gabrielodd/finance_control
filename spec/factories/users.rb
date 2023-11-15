FactoryGirl.define do
  factory :user do
    email { 'gabrieloddone@gmail.com' }
    admin { false }
    password { 'asjf93458f' }
  end
end
