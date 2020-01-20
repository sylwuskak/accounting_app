class FixTimestamp < ActiveRecord::Migration[5.2]
  def change
    Operation.all.select{|o| o.invoice_no == '458/11/2019'}.each do |operation|
      operation.created_at = operation.created_at + 20.hours
      operation.save!
    end
  end
end
