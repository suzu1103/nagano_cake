class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)

    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name

    elsif params[:order][:address_option] == "1"
        if Address.exists?(name: params[:order][:address_id])
          @order.postal_code = Address.find(params[order][:address_id]).postal_code
          @order.address = Address.find(params[order][:address_id]).address
          @order.name = Address.find(params[order][:address_id]).full_name
        else
          render :new
        end

    elsif params[:order][:address_option] == "2"
          @order.postal_code = params[:order][:postal_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]

    else
        redirect_to new_order_path
    end
  end

  def create
    @order = Order.new(order_params)

    @order.save
    redirect_to complete_orders_path

  end



  def index
  end

  def show
  end


  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

end
