FactoryGirl.define do
  factory :offer do
    association :user
    association :trade_request
    status 'pending'

    trait :approved do
      status 'approved'
    end
  end
end
