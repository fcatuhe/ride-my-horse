class Booking < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :horse, required: true
  validates :date, presence: true
  validates :date, uniqueness: { scope: :horse }
end
