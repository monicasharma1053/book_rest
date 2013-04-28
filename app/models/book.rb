class Book < ActiveRecord::Base
  attr_accessible :author, :description, :isbn, :price, :title


  has_many :carts, dependent: :destroy
  has_many :orders, through: :carts

  def self.search(condition)
    if condition
      search_condition = "%#{condition.downcase}%"
      find(:all, conditions: [ 'lower(author) LIKE ? OR lower(title) LIKE ? OR lower(isbn) LIKE ?', search_condition, search_condition, search_condition ])
    else
      find(:all)
    end
  end
end
