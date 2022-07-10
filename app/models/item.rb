class Item < ApplicationRecord
  has_one_attached :image
  enum is_active: { sale: true, stop_selling: false }
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  
  def with_tax_price
    (price * 1.1).floor
  end
end
