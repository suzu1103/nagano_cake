class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.find(params[:id])
  end

  def edit
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
