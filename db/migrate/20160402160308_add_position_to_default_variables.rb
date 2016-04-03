class AddPositionToDefaultVariables < ActiveRecord::Migration[5.0]
  def change
    add_column :default_variables, :position, :integer, null: false
  end
end
