class Item < ApplicationRecord
  has_one_attached :image
  # enum is_active: { sale: true, stop_selling: false }, _prefix: true
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :genre_id, presence: true
  validates :image, presence: true

  def with_tax_price
    (price * 1.1).floor
  end
  
  
end
