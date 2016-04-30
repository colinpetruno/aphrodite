namespace :seed  do
  desc "Seed Pricing Plans"
  task :pricing_plans => :environment do
    PricingPlan.
      find_or_create_by(
        name: "Personal", 
        price: 999, 
        number_of_users: 1,
        number_of_requests: 50000,
        slack_integration: false
      )
    PricingPlan.
      find_or_create_by(
        name: "Business", 
        price: 4999, 
        number_of_requests: 250000,
        slack_integration: false
      )
    PricingPlan.
      find_or_create_by(
        name: "Personal", 
        price: 24999, 
        number_of_requests: 1500000,
        slack_integration: false
      )
  end
end
