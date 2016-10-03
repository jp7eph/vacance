class BandsController < ApplicationController

  def index
    @bands = Band.all
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_path(@band)
    else
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    band = Band.find(params[:id])
    band.update(band_params)
    band.save
    redirect_to action: :index
  end

  def destroy
    band = Band.find(params[:id])
    band.delete
    redirect_to action: :index
  end

  def show
    @band = Band.find(params[:id])
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
