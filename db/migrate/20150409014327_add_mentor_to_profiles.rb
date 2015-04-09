class AddMentorToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :mentor_id, :uuid, index: true
  end
end
