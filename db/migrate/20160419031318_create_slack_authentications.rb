class CreateSlackAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_authentications do |t|
      t.references :account
      t.string :token
      t.string :team_id

      t.timestamps
    end
  end
end
