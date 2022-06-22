class Item < ApplicationRecord
  has_one_attached :image
  enum is_active: { sale: true, stop_selling: false }
  belongs_to :genre

end
