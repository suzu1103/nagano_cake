class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    # @order_detail = OrderDetail.find(params[:id])
    @order_details = @order.order_details

    # @customer = Customer.find(params[:id])
  end


end
