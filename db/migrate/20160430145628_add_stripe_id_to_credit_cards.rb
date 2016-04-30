class AddStripeIdToCreditCards < ActiveRecord::Migration[5.0]
  def change
    add_column :credit_cards, :stripe_id, :string
  end
end
