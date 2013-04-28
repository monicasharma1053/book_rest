class Cart < ActiveRecord::Base
  attr_accessible :book_id, :order_id


  belongs_to :order
  belongs_to :book


end
