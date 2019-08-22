class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  before_action :check_user_permission, only: [:edit, :update, :destroy]

  def index
    @places = Place.order("name").page(params[:page]).per_page(10)
  end

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.create(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @place = Place.find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def update
    @place.update_attributes(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @place.destroy
    redirect_to root_path
  end

  private

  def check_user_permission
    if @place.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end
  end

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end

end
