class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
  end

  def create
    #@item = Item.find(cart_item_params[:item_id])
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to public_cart_items_path
  end

  def update
    @cart_items = current_customer.cart_items.find(params[:id])
    if @cart_items.update(cart_item_params)
      redirect_to public_cart_items_path
    else
      render index
    end
  end

  def destroy
    @cart_items = current_customer.cart_items.find(params[:id])
    @cart_items.destroy
    redirect_to public_cart_items_path
  end

  def all_destroy
    @cart_items = current_customer.cart_items.destroy_all
    #@cart_items.destroy
    redirect_to public_cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
