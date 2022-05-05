class Public::CartItemsController < ApplicationController
  def index
  end

  def create
    @cart_item = current_user.cart_items.build(cart_item_params)
    @cart_item.save
  end

  def update
  end

  def destroy
  end

  def all_destroy
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
