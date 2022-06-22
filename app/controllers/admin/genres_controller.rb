class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
    # binding.pry
  end

  def create
    @genres = Genre.new(genre_params)
    @genres.save
    redirect_to admin_genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end


  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
