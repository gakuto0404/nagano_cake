class Admin::CustomersController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end
  
  def update
  end
  
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :last_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_active)
  end
end
