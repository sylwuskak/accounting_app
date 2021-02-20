class UpdateConfiguration2021 < ActiveRecord::Migration[5.2]
  def change
    conf = AppConfiguration.where(year: 2021).first
    conf.health_amount_reduction = 328.78
    conf.save!
  end
end
