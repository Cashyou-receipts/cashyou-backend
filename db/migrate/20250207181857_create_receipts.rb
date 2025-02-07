class CreateReceipts < ActiveRecord::Migration[7.1]
  def change
    create_table :receipts do |t|
      t.string :vendor_id
      t.float :balance
      t.float :tax
      t.float :subtotal

      t.timestamps
    end
  end
end
