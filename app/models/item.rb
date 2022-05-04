class Item < ApplicationRecord

  has_many :order_details
  has_many :cart_items

  belongs_to :genre

  has_one_attached :image
  validates :is_active, inclusion: { in: [true, false] }
end
