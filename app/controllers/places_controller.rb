class PlacesController < ApplicationController
  def index
    @places = Place.all.order(:id)
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      redirect_to place_path(@place)
    else
      render :new
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def destroy
    place = Place.find(params[:id])
    place.delete
    redirect_to action: :index
  end
  def update
    place = Place.find(params[:id])
    place.update(place_params)
    place.save
    redirect_to action: :index
  end

  def show
    @place = Place.find(params[:id])
  end

  private

  def place_params
    params.require(:place).permit(:name)
  end
end
