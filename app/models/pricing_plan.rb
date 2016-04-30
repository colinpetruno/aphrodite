class PricingPlan < ApplicationRecord
  has_many :accounts

  def price_in_dollars
    price / 100
  end
end
