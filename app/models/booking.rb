class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :horse
  validates :date, presence: true
end
