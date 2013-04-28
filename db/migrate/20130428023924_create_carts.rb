class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :order_id
      t.string :book_id

      t.timestamps
    end
  end
end
