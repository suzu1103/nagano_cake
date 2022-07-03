class Order < ApplicationRecord
  def full_name
    self.last_name + " " + self.first_name
  end
  
  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
  
  # 小計を求めるメソッド
  def subtotal
    order_detail.with_tax_price * amount
  end
  
  belongs_to :customer
  
end
