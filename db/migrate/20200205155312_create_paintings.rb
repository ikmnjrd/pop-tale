class CreatePaintings < ActiveRecord::Migration[5.2]
  def change
    create_table :paintings do |t|
      t.references :user, foreign_key: true
      t.text :description

      t.timestamps
    end
    #add_index :microposts, [:user_id, :created_at]
  end
end
