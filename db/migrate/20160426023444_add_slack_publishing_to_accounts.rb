class AddSlackPublishingToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :slack_publishing, :boolean, default: false, null: false
  end
end
