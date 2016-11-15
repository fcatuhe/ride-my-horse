class HorsesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create] # remove new and create when finished testing
  before_action :set_horse, only: [:show]

  def index
    @horses = Horse.all
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
