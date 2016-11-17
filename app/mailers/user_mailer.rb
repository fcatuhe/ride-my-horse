class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Ride My Horse!')
  end

  def confirm_booking(booking)
    @booking = booking
    mail(to: @booking.horse.user.email, subject: 'Can you please confirm booking by ' + @booking.user.email + ' ?')
  end

  def booking_confirmed(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'Your booking has been confirmed by ' + @booking.horse.user.email )
  end
end
