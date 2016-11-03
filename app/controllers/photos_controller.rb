class PhotosController < ApplicationController

  before_filter :require_user, only: [:create]

  def index
    @photos = Photo.all
    render json: @photos
  end

  def create
    # photo_params == {photo: FILE, caption: 'String'}
    our_params = photo_params
    # Assigns value of file to be what was in our_params[:photo]
    # And removes [:photo] from our_params
    file = our_params.delete(:photo) # our_params == {caption: 'String'}; file == FILE
    our_params[:image] = file # Setting :image key to what was in :photo
    # our_params == {image: FILE, caption: 'String'}
    our_params[:user] = current_user
    @photo = Photo.new(our_params)
    if @photo.save
      render json: @photo
    else
      render json: @photo.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @photo = Photo.find(params[:id])
    render json: @photo
  end

  private

  def photo_params
    params.permit(:photo, :caption) # A Hash
  end

end
