class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).per(8)
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
