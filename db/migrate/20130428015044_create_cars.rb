class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :order_id
      t.string :book_id

      t.timestamps
    end
  end
end
