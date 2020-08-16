class AddColumnPaintings < ActiveRecord::Migration[5.2]
  def change
    add_column :paintings, :price, :integer
  end
end