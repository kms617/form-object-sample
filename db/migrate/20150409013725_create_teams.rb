class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams, id: :uuid do |t|
      t.timestamps null: false
      t.string :name
    end
  end
end
