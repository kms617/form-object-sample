class AddManagerAssociation < ActiveRecord::Migration
  def change
    add_column :profiles, :manager_id, :uuid, index: true
  end
end
