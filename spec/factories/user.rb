FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "test#{n}@example.com"
    end
    sequence :username do |n|
      "JoeShmo#{n}"
    end
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.now
  end
end
