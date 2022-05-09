class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
    @total = 0
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @cart_item.item_id = params[:cart_item][:item_id]
    current_cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    #選択した商品が既にカート内に存在するの判別
    if current_cart_item.present?
      current_cart_item.amount += params[:cart_item][:amount].to_i   #カート内の個数をフォームから送られた個数分追加する
      current_cart_item.save
      redirect_to public_cart_items_path
    else
      #選択した商品がカート内に存在しない場合
      @cart_item.save
      redirect_to public_cart_items_path
    end
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
    redirect_to public_cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
