class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.decimal :price
      t.string :description
      t.string :isbn

      t.timestamps
    end
  end
end
