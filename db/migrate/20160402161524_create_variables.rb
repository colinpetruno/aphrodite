class CreateVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :variables do |t|
      t.references :stylesheet
      t.string :name
      t.string :value
      t.string :preview_value
      t.integer :position
      t.boolean :default
      t.integer :category_id

      t.timestamps
    end
  end
end
