class Item < ApplicationRecord
  has_one_attached :image
  enum is_active: { sale: 0, stop_selling: 1 }
end
