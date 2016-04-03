class AddAccountToStylesheets < ActiveRecord::Migration[5.0]
  def change
    add_reference :stylesheets, :account, foreign_key: true
  end
end
