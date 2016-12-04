FactoryGirl.define do
  factory :review do
    reviewed_user_id 1
    reviewing_user_id 1
    tone "MyString"
    offer_id 1
  end
end
