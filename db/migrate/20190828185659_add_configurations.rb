class AddConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :app_configurations do |t|
      t.date :date_from
      t.date :date_to

      t.float :base
      t.float :health_base
      t.float :income_tax_threshold

      t.float :retirement_percent
      t.float :disability_percent
      t.float :accidental_percent
      t.float :illness_percent
      t.float :fp_percent
      t.float :health_percent
      t.float :health_deduction_percent

      t.float :first_tax_rate
      t.float :second_tax_rate
      t.float :second_tax_amount

      t.references :user, null: false
    end
  end
end
