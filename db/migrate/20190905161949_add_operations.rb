class AddOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.string :operation_type, null: false
      t.float :amount
      t.text :description
      t.date :date
      
      t.references :user, null: false
    end 
  end
end
