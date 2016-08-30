FactoryGirl.define do
  factory :user do
    account

    email "email@example.com"
    password "asdf1234"
    password_confirmation "asdf1234"
  end
end
