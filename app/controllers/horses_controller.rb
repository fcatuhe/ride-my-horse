class HorsesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_horse, only: [:show]

  def index
    @horses = Horse.all
  end

  def show
  end

  private

  def set_horse
    @horse = Horse.find(params[:id])
  end

  def horse_params
    params.require(:horse).permit(:name, :user, :category, :price, :address, :equipment, :description, :photo)
  end
end
