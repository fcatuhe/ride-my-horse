class HorsesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_horse, only: [:show, :edit, :update, :destroy]

  def index
    search = params[:search]

    @horses = Horse.where.not(latitude: nil, longitude: nil)

    if search.try(:[], :address) && search[:address] !=""
      @address = search[:address]
      @horses = @horses.near(search[:address], 100)
    end

    if search.try(:[], "date(1i)")
      @date = Date.new(search["date(1i)"].to_i, search["date(2i)"].to_i, search["date(3i)"].to_i)
      @horses = @horses.joins(:availabilities).where('start_at <= ?', @date).where('finish_at >= ?', @date)
    end

    @hash = Gmaps4rails.build_markers(@horses) do |horse, marker|
      marker.lat horse.latitude
      marker.lng horse.longitude
      marker.infowindow render_to_string(partial: "horses/card_horse_address", locals: { horse: horse })
    end

  end

  def show
    @horse = Horse.find(params[:id])
    @booking = @horse.bookings.new
    @horse_coordinates = {lat: @horse.latitude, lng: @horse.longitude}
    @alert_message = "You are viewing #{@horse.name}"
    @hash = Gmaps4rails.build_markers(@horse) do |horse, marker|
      marker.lat horse.latitude
      marker.lng horse.longitude
    end

  end

  def new
    @horse = Horse.new
  end

  def create
    @horse = current_user.horses.new(horse_params)
    if @horse.save
      redirect_to @horse.user
    else
      render :new
    end
  end

  def edit
  end

  def update
    @horse.update(horse_params)
    if @horse.save
      redirect_to @horse
    else
      render :edit
    end
  end

  def destroy
    @horse.destroy
    redirect_to horses_path
  end

  private

  def set_horse
    @horse = Horse.find(params[:id])
  end

  def horse_params
    params.require(:horse).permit(:name, :category_id, :price, :address, :equipment, :description, :photo)
  end
end
