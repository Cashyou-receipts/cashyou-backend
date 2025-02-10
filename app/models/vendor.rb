class Vendor < ApplicationRecord
  has_many :users, through: :user_vendor
  has_many :receipts
  has_many :items
end
