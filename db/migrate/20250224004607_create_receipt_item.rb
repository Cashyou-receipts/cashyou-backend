class CreateReceiptItem < ActiveRecord::Migration[7.1]
  def change
    create_table :receipt_items do |t|
      t.bigint :receipt_id
      t.bigint :vendor_id
      t.bigint :item_id
      t.float :price

      t.timestamps
    end
  end
end
