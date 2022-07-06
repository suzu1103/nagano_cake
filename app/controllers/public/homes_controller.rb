class Public::HomesController < ApplicationController
  def top
    @items = Item.order('id DESC').limit(4)
    # @item = Item.find(params[:id])
  end

  def about
  end
end
