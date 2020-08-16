class AddPictureToPaintings < ActiveRecord::Migration[5.2]
  def change
    add_column :paintings, :picture, :string
  end
end
