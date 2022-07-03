class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = Order_detail.find(params[:id])
    @total = 
  end
end
