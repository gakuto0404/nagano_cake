class Admin::ItemsController < ApplicationController
  def index
  end

  def create

  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :genre_id, :price, :is_active)
  end
end
