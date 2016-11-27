FactoryGirl.define do
  factory :offer do
    association :user
    association :trade_request
    status "pending"
  end
end
