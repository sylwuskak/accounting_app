class AddFieldsToOperations < ActiveRecord::Migration[5.2]
  def change
    add_column :operations, :invoice_no, :string
    add_column :operations, :contractor_name, :string
    add_column :operations, :contractor_address, :string
    add_column :operations, :operation_subtype, :string
    add_column :operations, :other_cost_amount, :float
  end
end
