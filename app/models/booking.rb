class Booking < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :horse, required: true
  validates :date, presence: true
  validates :date, uniqueness: { scope: :horse }

  def stars
    ('<i class="fa fa-star" aria-hidden="true"></i>' * user_rating + '<i class="fa fa-star-o" aria-hidden="true"></i>' * (5 - user_rating)).html_safe if user_rating
  end
end
