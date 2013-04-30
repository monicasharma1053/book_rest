class Cart < ActiveRecord::Base
  attr_accessible :book_id, :order_id

  belongs_to :order
  belongs_to :book

  before_create :add_total_price
  before_destroy :minus_total_price

  protected
  def add_total_price
    book = Book.find(self.book_id)
    order = Order.find(self.order_id)
    unless order.status == "shipped"
      order.total_price += book.price
      order.save
    end
  end

  def minus_total_price
    book = Book.find(self.book_id)
    order = Order.find(self.order_id)
    unless order.status == "shipped"
      order.total_price -= book.price
      order.save
    end
  end
end