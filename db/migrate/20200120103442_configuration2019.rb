class Configuration2019 < ActiveRecord::Migration[5.2]
  def change
    AppConfiguration.create!(
      year: 2019,
      first_tax_rate: 17.75,
      second_tax_rate: 32,
      second_tax_amount: 85528,
      income_tax_threshold: 548.30,
      health_amount_reduction: 285.27
    )
  end
end
