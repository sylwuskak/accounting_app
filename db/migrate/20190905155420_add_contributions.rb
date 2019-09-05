class AddContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contributions do |t|
      t.string :contribution_type
      t.date :date
      t.float :amount

      t.references :user, null: false
    end

  end
end
