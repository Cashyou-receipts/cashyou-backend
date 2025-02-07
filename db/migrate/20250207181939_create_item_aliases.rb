class CreateItemAliases < ActiveRecord::Migration[7.1]
  def change
    create_table :item_aliases do |t|
      t.string :item_name
      t.string :alias

      t.timestamps
    end
  end
end
