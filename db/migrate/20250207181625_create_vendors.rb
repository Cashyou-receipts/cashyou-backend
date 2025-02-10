class CreateVendors < ActiveRecord::Migration[7.1]
  def change
    create_table :vendors do |t|
      t.string :name
      t.integer :default_category

      t.timestamps
    end
  end
end
