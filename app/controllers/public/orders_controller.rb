class Public::OrdersController < ApplicationController
  def new
    @order = current_customer.orders.new
  end
  
  def create
    @order = current_customer.orders.new(order_params)
    
    
  end

  def confirm
    @order = current_customer.orders.new(order_params)
    @orde.save
    redirect_to confirm_orders_path
  end

  def index
  end

  def show
  end
end
