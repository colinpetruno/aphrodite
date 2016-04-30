class AddPricingPlanIdToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_reference :accounts,
      :pricing_plan,
      foreign_key: true,
      null: false,
      default: 1
  end
end
