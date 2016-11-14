class Horse < ApplicationRecord
  belongs_to :user
  has_one :category
  has_many :availabilities, dependent: :destroy
  has_many :bookings
  validates :name, presence: true
  validates :price, presence: true
  validates :address, presence: true
  validates :equipment, presence: true
  validates :description, presence: true
end
