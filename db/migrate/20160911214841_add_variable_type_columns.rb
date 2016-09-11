class AddVariableTypeColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :variables, :variable_type, :integer
    add_column :default_variables, :variable_type, :integer
  end
end
