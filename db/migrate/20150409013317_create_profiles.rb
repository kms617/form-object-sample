class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles, id: :uuid do |t|
      t.timestamps null: false
      t.text :bio
      t.string :first_name
      t.string :last_name
      t.string :slack_handle
      t.string :title
    end
  end
end
