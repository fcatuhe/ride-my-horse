class Booking < ApplicationRecord
  belongs_to  :user, required: true
  belongs_to  :horse, required: true
  validates   :date, presence: true
  validates   :date, uniqueness: { scope: :horse,
    message: "This horse already has a cavalier for this day" }

  after_create :send_confirm_booking
  after_update :send_booking_confirmed


  def stars
    ('<i class="fa fa-star" aria-hidden="true"></i>' * user_rating + '<i class="fa fa-star-o" aria-hidden="true"></i>' * (5 - user_rating)).html_safe if user_rating
  end

  private

  def send_confirm_booking
    UserMailer.confirm_booking(self).deliver_now
  end

  def send_booking_confirmed
    UserMailer.booking_confirmed(self).deliver_now if booking.validated_at != nil
  end

end
