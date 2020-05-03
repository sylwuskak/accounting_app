class Update2020Configuration < ActiveRecord::Migration[5.2]
  def change
    conf = AppConfiguration.where(year: 2020).first
    conf.health_amount_reduction = 312.02
    conf.save!
  end
end
