class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items

 def add_product(product_id)
     current_item = line_items.where(:product_id => product_id).first
     if current_item
       current_item.quantity += 1
     else
       current_item = LineItem.new(:product_id=>product_id)
       line_items << current_item
     end
      current_item
  end
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
 def paypal_url(return_url, notify_url)
  values = {
    :business => 'dixitp_1353654180_per@gmail.com',
    :cmd => '_cart',
    :upload => 1,
    :return => return_url,
    :invoice => id,
    :notify_url => notify_url
  }
  line_items.each_with_index do |item, index|
    values.merge!({
      "amount_#{index+1}" => item.product.price,
      "item_name_#{index+1}" => item.product.name,
      "item_number_#{index+1}" => item.id,
      "quantity_#{index+1}" => item.quantity
      })
     end
      "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
   end

end

