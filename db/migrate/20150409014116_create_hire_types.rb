class CreateHireTypes < ActiveRecord::Migration
  def change
    create_table :hire_types, id: :uuid do |t|
      t.timestamps null: false
      t.string :name, null: false
      t.integer :work_status, null: false, default: 0
    end
  end
end
