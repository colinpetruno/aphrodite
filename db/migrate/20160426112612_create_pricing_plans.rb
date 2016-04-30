class CreatePricingPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :pricing_plans do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :number_of_users
      t.integer :number_of_requests
      t.boolean :slack_integration, null: false, default: false
      t.integer :position

      t.timestamps
    end
  end
end
