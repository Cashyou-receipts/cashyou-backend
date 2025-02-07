class CreateUserVendors < ActiveRecord::Migration[7.1]
  def change
    create_table :user_vendors do |t|
      t.bigint :user_id
      t.bigint :vendor_id

      t.timestamps
    end
  end
end
