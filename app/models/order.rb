class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details
  
  validates :customer_id, presence: :true
  validates :postal_code, presence: :true
  validates :address, presence: :true
  validates :name, presence: :true
  validates :shipping_cost, presence: :true

  def owner_address
    '〒' + self.postal_code.to_s.insert(3, "-") + ' ' + self.address
  end

  def subtotal
    itme.add_tax_price * amount
  end
  
  def with_tax_price
    (price * 1.1).floor
  end

  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: { waiting: 0,  paid_up: 1,  making: 2,  preparing: 3,  shipped: 4 }
end
