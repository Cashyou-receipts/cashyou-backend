class CreateReceipts < ActiveRecord::Migration[7.1]
  def change
    create_table :receipts do |t|
      t.bigint :vendor_id
      t.bigint :user_id
      t.float :balance
      t.float :tax
      t.float :subtotal
      t.boolean :requires_attention, default: false

      t.timestamps
    end
  end
end
