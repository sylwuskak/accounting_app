class AddTimestampToOperations < ActiveRecord::Migration[5.2]
  def change
    add_column :operations, :created_at, :datetime, null: false, default: Time.zone.now

    Operation.all.each do |operation|
      operation.created_at = (operation.date + (0..100).to_a.sample.seconds)
      if operation.description == 'remament'
        operation.created_at = operation.date + 23.hours
      end
      
      operation.save!
    end
  end
end
