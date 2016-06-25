class PricingPlan < ApplicationRecord
  has_many :accounts

  def label
    I18n.t(".models.pricing_plan.label", name: name, price: price_in_dollars)
  end

  def price_in_dollars
    price.to_f / 100
  end
end
