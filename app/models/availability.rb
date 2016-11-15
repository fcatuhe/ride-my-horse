class Availability < ApplicationRecord
  belongs_to :horse, required: true
  validates :start_at, presence: true
  validates :finish_at, presence: true
end
