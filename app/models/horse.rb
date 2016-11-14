class Horse < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :availabilities, dependent: :destroy
  has_many :bookings
  validates :name, presence: true
  validates :price, presence: true
  validates :address, presence: true
  validates :equipment, presence: true
  validates :description, presence: true
end
