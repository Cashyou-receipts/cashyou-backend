class Receipt < ApplicationRecord
  belongs_to :vendor
  belongs_to :user
  has_many :items
end
