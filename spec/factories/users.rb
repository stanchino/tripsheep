# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "person-#{n}@example.com" }
    sequence(:first_name) {|n| "chuck-#{n}" }
    sequence(:last_name) {|n| "norris-#{n}" }
    password "password"
  end
end
