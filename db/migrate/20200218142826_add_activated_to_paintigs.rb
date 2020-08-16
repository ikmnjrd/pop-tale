class AddActivatedToPaintigs < ActiveRecord::Migration[5.2]
  def change
    add_column :paintings, :activated, :boolean, default: false
  end
end
