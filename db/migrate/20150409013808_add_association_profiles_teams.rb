class AddAssociationProfilesTeams < ActiveRecord::Migration
  def change
    add_column :profiles, :team_id, :uuid
    add_index :profiles, :team_id
  end
end
