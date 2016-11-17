class UserMailerPreview < ActionMailer::Preview
  def welcome
      user = User.first
      UserMailer.welcome(user)
  end

  def confirm_booking
    booking = Booking.first
    UserMailer.confirm_booking(booking)
  end

end
