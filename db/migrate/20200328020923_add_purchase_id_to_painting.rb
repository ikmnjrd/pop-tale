class AddPurchaseIdToPainting < ActiveRecord::Migration[5.2]
  def change
    add_column :paintings, :purchase_id, :integer, default: nil
  end
end
