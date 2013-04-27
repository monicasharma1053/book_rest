class Book < ActiveRecord::Base
  attr_accessible :author, :description, :isbn, :price, :title
end
