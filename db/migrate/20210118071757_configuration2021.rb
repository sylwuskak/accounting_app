class Configuration2021 < ActiveRecord::Migration[5.2]
  def change
    AppConfiguration.create!(
      year: 2021,
      first_tax_rate: 17,
      second_tax_rate: 32,
      second_tax_amount: 85528,
      income_tax_threshold: 525.12,
      health_amount_reduction: 0
    )
  end
end
