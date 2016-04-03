class CreateDefaultVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :default_variables do |t|
      t.string :name
      t.string :value
      t.string :framework
      t.string :version
    end
  end
end
