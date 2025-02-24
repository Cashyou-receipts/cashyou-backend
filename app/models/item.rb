class Item < ApplicationRecord
  belongs_to :vendor
  has_many :receipt_items
  has_many :receipts, through: :receipt_items
end
