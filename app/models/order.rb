class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :payment, :status, :total


  has_many :carts, dependent: :destroy
  has_many :books, through: :carts
end
