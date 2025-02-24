class AddItemJsonToReceipt < ActiveRecord::Migration[7.1]
  def change
    add_column :receipts, :item_json, :jsonb
  end
end
