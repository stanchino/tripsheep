# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    address "MyString"
    address1 "MyString"
    city "MyString"
    state "MyString"
    zip ""
    max ""
    country "MyString"
  end
end
