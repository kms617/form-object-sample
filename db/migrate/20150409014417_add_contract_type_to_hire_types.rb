class AddContractTypeToHireTypes < ActiveRecord::Migration
  def change
    add_column :hire_types, :contract_type, :integer, default: 0, null: false
  end
end
