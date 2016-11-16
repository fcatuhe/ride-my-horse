class Horse < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :category, required: true
  has_many :availabilities, dependent: :destroy
  has_many :bookings
  validates :name, presence: true
  validates :price, presence: true
  validates :address, presence: true
  validates :description, presence: true
  has_attachment :photo

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def stars
    ratings = bookings.map { |booking| booking.owner_rating}.select { |owner_rating| !owner_rating.nil? }
    rating = ratings.size > 0 ? ratings.sum.fdiv(ratings.size).round : 0
    ('<i class="fa fa-star" aria-hidden="true"></i>' * rating + '<i class="fa fa-star-o" aria-hidden="true"></i>' * (5 - rating)).html_safe
  end
end
