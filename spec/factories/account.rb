FactoryGirl.define do
  factory :account do
    pricing_plan

    name "Account"
    site_url "https://www.example.com"
    slack_publishing true
    stripe_id nil
  end
end
