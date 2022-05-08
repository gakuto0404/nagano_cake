class Item < ApplicationRecord

  has_many :order_details
  has_many :cart_items

  belongs_to :genre

  has_one_attached :profile_image
  validates :is_active, inclusion: { in: [true, false] }

  def with_tax_price
    (price * 1.1).floor
  end



  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
