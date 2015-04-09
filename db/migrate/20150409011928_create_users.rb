class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.timestamps null: false
      t.string :email, null: false
    end
    add_index :users, :email, unique: true
  end
end
