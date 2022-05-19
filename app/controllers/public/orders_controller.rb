class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @addresses = current_customer.addresses
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    # カート商品
    cart_items = current_customer.cart_items
    #請求金額
    @total = cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_payment = @total + params[:order][:shipping_cost].to_i
    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item.id
        order_detail.price = cart_item.subtotal.to_s
        order_detail.amount = cart_item.amount
        order_detail.order_id = @order.id
        order_detail.save
      end
      cart_items.destroy_all
      redirect_to public_orders_thanx_path
    else
      redirect_to new_public_order_path
    end
  end

  def log
    @order = Order.new
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
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = @order.total_payment - @order.shipping_cost
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :total_payment, :status, :shipping_cost)
  end
end
