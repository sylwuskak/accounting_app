class ConfigurationChanges < ActiveRecord::Migration[5.2]
  def change
    remove_column :app_configurations, :date_from, :date
    remove_column :app_configurations, :date_to, :date
    add_column :app_configurations, :year, :integer
    remove_column :app_configurations, :base, :float
    remove_column :app_configurations, :health_base, :float
    remove_column :app_configurations, :retirement_percent, :float
    remove_column :app_configurations, :disability_percent, :float
    remove_column :app_configurations, :accidental_percent, :float
    remove_column :app_configurations, :illness_percent, :float
    remove_column :app_configurations, :fp_percent, :float
    remove_column :app_configurations, :health_percent, :float
    remove_column :app_configurations, :health_deduction_percent, :float
    remove_column :app_configurations, :user_id, :integer
    add_column :app_configurations, :health_amount_reduction, :float
  end
end
