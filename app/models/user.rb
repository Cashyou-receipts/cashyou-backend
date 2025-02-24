class User < ApplicationRecord
  has_many :receipts
  has_many :user_vendors
  has_many :vendors, through: :user_vendors
end
