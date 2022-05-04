class Admin::HomesController < ApplicationController
  def top
    @customers = Customer.find(params[:id])
    @orders = 
  end
end
