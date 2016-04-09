class CreateDefaultVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :default_variables do |t|
      t.string :name
      t.string :value
      t.string :framework
      t.string :version
      t.integer :category_id
    end
  end
end
