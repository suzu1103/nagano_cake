class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details

  def full_name
    self.last_name + " " + self.first_name
  end

  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end

  # 小計を求めるメソッド
  def subtotal
    order_details.price * order_details.amount
  end

  enum payment_method: { credit_card: 0, transfer: 1 }
end
