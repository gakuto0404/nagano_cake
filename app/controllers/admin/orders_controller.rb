class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def edit
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order.total_payment - @order.shipping_cost
  end

  def update
    @order = Order.find(params[:id])
    @order.status = params[:order][:status].to_i
    if @order.update(order_params)
      redirect_to edit_admin_order_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
