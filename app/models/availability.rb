class Availability < ApplicationRecord
  belongs_to :horse
  validates :start_at, presence: true
  validates :finish_at, presence: true
end
