class AvailabilitiesController < ApplicationController
  def new
    horse = Horse.find(available_horse_params[:horse])
    @availability = horse.availabilities.new
  end

  def create
    @availability = Availability.new(availability_params)
    if @availability.save
      redirect_to current_user
    else
      render 'availabilities/new'
    end
  end

  private
  def availability_params
    params.require(:availability).permit(:horse_id, :start_at, :finish_at)
  end

  def available_horse_params
    params.require(:available_horse).permit!
  end
end
