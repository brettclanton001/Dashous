FactoryGirl.define do
  factory :trade_request do

    association :user

    name 'Great Trade'
    kind 'sell'
    profit '2'
    location 'New York City, New York'
    longitude -74.0059413
    latitude 40.7127837
    active true

    trait :new_york do
      location 'New York City, New York'
      longitude -74.0059413
      latitude 40.7127837
    end

    trait :stamford do
      location 'Stamford'
      longitude -74.614318
      latitude 42.4073024
    end
  end
end
