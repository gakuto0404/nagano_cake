class OrderDetail < ApplicationRecord
  
  belongs_to :items
  belongs_to :or
  
end
