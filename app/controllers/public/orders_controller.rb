class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @address = current_customer.addresses.all
    @order = Order.new
  end

  def log
    @order = Order.new(order_params)
    #配送料
    @order.shipping_cost = 800
    # カート商品
    @cart_items = current_customer.cart_items
    #合計金額
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    #支払方法
    @order.payment_method = params[:order][:payment_method]
    #請求金額
    @total_payment = @total + @order.shipping_cost

    #配送先選択
    if params[:order][:address_select] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    elsif params[:order][:address_select] == "1"
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      @order.address = Address.find(params[:order][:address_id]).address
      @order.name = Address.find(params[:order][:address_id]).name
    elsif params[:order][:address_select] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end

  def thanx
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end
