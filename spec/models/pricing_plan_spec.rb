require "rails_helper"

RSpec.describe PricingPlan, type: :model do
  describe "#label" do
    it "should include the name, price and trial information" do
      pricing_plan = create(:pricing_plan, price: 8493, name: "Test Plan")

      expect(pricing_plan.label).
        to eql(I18n.t(".models.pricing_plan.label",
                      price: "84",
                      name: "Test Plan" ))
    end
  end

  describe "#price_in_dollars" do
    it "should only be a whole number" do
      pricing_plan = create(:pricing_plan, price: 394)

      expect(pricing_plan.price_in_dollars).to eql(3)
    end
  end
end
