class Item < ApplicationRecord
  belongs_to :ganre
  has_one_attached :image
  validates :is_active, inclusion: { in: [true, false] }
end
