class BookingsController < ApplicationController

  def create
    @horse = Horse.find(params[:horse_id])
    raise
    @booking = @horse.bookings.new(booking_params)

    if booking.save
      redirect_to @horse

    else
      render 'horses/show'
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    render 'horses/show'
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :horse_id, :date)
  end

end
