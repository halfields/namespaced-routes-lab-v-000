class ArtistsController < ApplicationController
  before_action  :set_artist, only: [:show, :edit, :update, :destroy]


  def index
    @preferences = Preference.first
    if @preferences && @preferences.artist_sort_order
      @artists = Artist.order(namae: @preferences.artist_sort_order)
    else
      @artists = Artist.all 
    end
  end

  def show
  end

  def new
    @preferences = Preference.first
    if @preferences && !@preferences.allow_create_artists
      redirect_to artists_path
    else
      @artist = Artist.new
    end
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def edit
  end

  def update
    @artist.update(artist_params)
    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end

  def set_artist
    @artist = Artist.find(params[:id])
  end


end
