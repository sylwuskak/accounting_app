class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :app_configurations, dependent: :destroy
  has_many :contributions, dependent: :destroy
  has_many :operations, dependent: :destroy
end
