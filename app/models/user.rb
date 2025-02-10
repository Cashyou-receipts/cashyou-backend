class User < ApplicationRecord
  has_many :receipts
  has_many :vendors, through: :user_vendor
end
