class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :payment, :status, :total
end
