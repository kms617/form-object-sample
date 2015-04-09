class AddAssociationProfilesHireTypes < ActiveRecord::Migration
  def change
    add_column :profiles, :hire_type_id, :uuid, index: true
  end
end
