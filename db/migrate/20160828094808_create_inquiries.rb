class CreateInquiries < ActiveRecord::Migration[5.0]
  def change
    create_table :inquiries do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
