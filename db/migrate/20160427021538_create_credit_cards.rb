class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.string :description
      t.references :account
      t.string :last_4
      t.string :token

      t.timestamps
    end
  end
end
