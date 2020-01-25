class Configuration2020 < ActiveRecord::Migration[5.2]
  def change
    add_column :app_configurations, :health_amount, :float

    AppConfiguration.all.select{|c| c.year == 2019}.each do |c|
      c.health_amount = 342.32
      c.save!
    end

    AppConfiguration.create!(
      year: 2020,
      first_tax_rate: 17.75,
      second_tax_rate: 32,
      second_tax_amount: 85528,
      income_tax_threshold: 525.12,
      health_amount: 362.34,
      health_amount_reduction: 213.02
    )
  end
end
