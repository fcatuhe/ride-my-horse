class HorsesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create] # remove new and create when finished testing
  before_action :set_horse, only: [:show]

  def index
    search = params[:search]

    if search.try(:[], :address)
      @horses = Horse.where(address: search[:address])
      # @horses = Horse.near(params[:search][:address], 10)
    end

    if params[:search].try(:[], "date(1i)")
      date = Date.new(search["date(1i)"].to_i, search["date(2i)"].to_i, search["date(3i)"].to_i)
      # @horse.join(:availabilities).where('start_at <= ?', date).where('finish_at >= ?', date)
    end
    @horses = Horse.all if @horses.nil?
  end

  def show
  end

  def new
    @horse = Horse.new
  end

  def create
    @horse = Horse.new(horse_params)
    if @horse.save
      redirect_to @horse
    else
      render :new
    end
  end

  private

  def set_horse
    @horse = Horse.find(params[:id])
  end

  def horse_params
    params.require(:horse).permit(:name, :user, :category, :price, :address, :equipment, :description, :photo)
  end
end
