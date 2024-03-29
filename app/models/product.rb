class Product < ActiveRecord::Base
  attr_accessible :description, :image, :name, :price
  validates :description, :name, :image , :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :name,  :uniqueness => true
  validates :image, :format => { :with => %r{\.(gif|jpg|png)$}i, :message =>'must be a URL for GIF, JPG or PNG image.'}
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  def ensure_not_referenced_by_any_line_item
  	if line_items.count.zero?
      return true
    else
      errors[:base] << "Line Items present"
     return false
    end

  end

end
