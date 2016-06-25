FactoryGirl.define do
  factory :pricing_plan do
    name "Personal"
    price 999
    number_of_users 1
    number_of_requests 50000
    slack_integration false
  end
end
