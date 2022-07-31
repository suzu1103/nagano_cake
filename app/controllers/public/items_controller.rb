class Public::ItemsController < ApplicationController

  def index
    # @items = Item.page(params[:page]).per(8)

    # @genres = Genre.where(is_active: true)
    # if params[:genre_id]
		  # @genre = Genre.find(params[:genre_id])
		  # @items = @genre.products.where(is_active: true).page(params[:page]).reverse_order
    # else
      @items = Item.where(is_active: true).page(params[:page]).reverse_order
    # end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end


  private
  def item_params
    params.require(:items).permit(:image, :name, :introduction, :genre_id, :price)
  end

end
