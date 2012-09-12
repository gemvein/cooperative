FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "person#{n}@example.com" }
    sequence(:nickname) {|n| "person#{n}" }
    password "password"
  end
end