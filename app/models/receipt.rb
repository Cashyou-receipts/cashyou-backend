class Receipt < ApplicationRecord
  belongs_to :vendor, optional: true
  belongs_to :user
  has_many :receipt_items
  has_many :items, through: :receipt_items
  after_create :create_items, if: :has_vendor?
  before_update :create_items, if: :saved_change_to_vendor_id?

  def create_items
    item_json.each do |incoming_item|
      item_name, item_price = incoming_item.first
      next unless item_name && item_price.to_f > 0
      new_item = Item.find_or_create_by(name: item_name, vendor: vendor)
      receipt_items.create(item: new_item, price: item_price.to_f.round(2))
    end
  end

  def has_vendor?
    vendor_id
  end
end
