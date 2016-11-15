class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :horse
  validates :user, presence: true
  validates :horse, presence: true
  validates :date, presence: true
end
