class AddAssociationProfilesUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_id, :uuid
    add_index :users, :profile_id
  end
end
