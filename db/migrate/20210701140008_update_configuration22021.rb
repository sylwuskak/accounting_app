class UpdateConfiguration22021 < ActiveRecord::Migration[5.2]
  def change
    conf = AppConfiguration.where(year: 2021).first
    conf.health_amount = 381.81
    conf.save!
  end
end
