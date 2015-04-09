class AddCommunicationStyleToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :communication_style, :string
  end
end
