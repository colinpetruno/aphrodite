class CreateStylesheets < ActiveRecord::Migration[5.0]
  def change
    create_table :stylesheets do |t|
      t.string :name
      t.string :framework
      t.string :version

      t.timestamps
    end
  end
end
