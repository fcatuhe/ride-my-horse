class HorsesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_horse, only: [:show, :edit, :update, :destroy]

  def index
    search = params[:search]

    if search.try(:[], :address)
      @horses = Horse.where(address: search[:address])
      # @horses = Horse.near(search[:address], 10)
    end

    if search.try(:[], "date(1i)")
      date = Date.new(search["date(1i)"].to_i, search["date(2i)"].to_i, search["date(3i)"].to_i)
      @horses = @horses.joins(:availabilities).where('start_at <= ?', date).where('finish_at >= ?', date)
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
    params.require(:horse).permit(:name, :user_id, :category_id, :price, :address, :equipment, :description, :photo)
  end
end
