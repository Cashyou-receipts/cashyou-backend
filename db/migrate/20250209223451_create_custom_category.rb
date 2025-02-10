class CreateCustomCategory < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_categories do |t|
      t.bigint :vendor_id
      t.bigint :user_id
      t.string :category_name

      t.timestamps
    end
  end
end
