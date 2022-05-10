class Public::OrdersController < ApplicationController
  def new
    @address = current_customer.addresses.all
    @order = Order.new
  end

  def log
  end

  def thanx
  end

  def index
  end

  def show
  end
end
