FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "test#{n}@example.com"
    end
    sequence :username do |n|
      "Joe Shmo #{n}"
    end
    password 'password'
    password_confirmation 'password'
  end
end
