class Operation < ActiveRecord::Base
  belongs_to :user

  validates :date, presence: true
  validates :amount, presence: true

end