class PricingPlan < ApplicationRecord
  has_many :accounts

  def label
    "#{name} ($#{price_in_dollars} - 1 Week Free)"
  end

  def price_in_dollars
    price / 100
  end
end
