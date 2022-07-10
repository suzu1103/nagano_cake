class Public::OrdersController < ApplicationController
  def new
    @orders = current_customer.orders.new
  end

  def confirm
    @orders = current_customer.orders.new(order_params)
    @order.save
    redirect_to confirm_orders_path
  end

  def index
  end

  def show
  end
end
