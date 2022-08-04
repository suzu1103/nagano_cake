class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :confirm, :create, :index, :show]
  before_action :logged_in_customer, only: [:edit, :update]

  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def confirm
    @order = Order.new
    @order.payment_method = params[:order][:payment_method]
    @order.total_payment = params[:order][:total_payment]

    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name

    elsif params[:order][:address_option] == "1"
          ship = Address.find(params[:order][:address_id])
          @order.postal_code = ship.postal_code
          @order.address = ship.address
          @order.name = ship.name

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
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = cart_item.item.price
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to complete_orders_path
  end

  def index
    @order = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end


  private

  def order_params
    params.require(:order).permit(:payment_method, :total_payment, :shipping_cost, :customer_id, :postal_code, :address, :name, :address_option, :address_id)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

  def authenticate_customer
    unless customer_signed_in? == current_customer
      redirect_to new_customer_session_path
    end
  end


end
