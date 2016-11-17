class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy, :edit, :update]

  def index
    @bookings = Booking.all
  end

  def show
  end

  def create
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
      redirect_to current_user
    else
      @horse = @booking.horse
      render 'horses/show'
    end
  end

  def edit
  end

  def update
    @booking.update(booking_params)
    if @booking.save
      redirect_to current_user
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    render 'horses/show'
  end

  private

  def booking_params
    params.require(:booking).permit(:horse_id, :date, :validated_at, :user_rating, :user_comment, :owner_rating, :owner_comment)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
