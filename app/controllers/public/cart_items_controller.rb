class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items = current_customer.cart_items
  end

  def create
    # if文内に+-の計算式、~.find_byで検索機能を使う↓
    @cart_items = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
                                              # カート内に既にある商品：item_id
                                              # 追加分：params[cart_item][item_id]
        cart_items = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        @amount = cart_items.amount + params[:cart_item][:amount].to_i
              # cart_item.amountに、追加分のparams[:cart_item][:amount]を加える。
        cart_items.update(amount: @amount)
        redirect_to cart_items_path

    elsif @cart_items.save
          redirect_to cart_items_path

    else
      @cart_items = current_customer.cart_items.all
      render :index
    end

  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :price, :customer_id)
  end

end
