class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
  end

  def create
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
      redirect_to @booking.user
    else
      @horse = @booking.horse
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
    params.require(:booking).permit(:horse_id, :date)
  end

end
