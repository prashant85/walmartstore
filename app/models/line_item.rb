class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id
  belongs_to :cart
  belongs_to :product
  def total_price
      product.price * quantity
  end

end
