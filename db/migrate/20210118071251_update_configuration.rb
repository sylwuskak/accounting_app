class UpdateConfiguration < ActiveRecord::Migration[5.2]
  def change
    conf = AppConfiguration.where(year: 2020).first
    conf.first_tax_rate = 17
    conf.save!
  end
end
