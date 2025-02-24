class Receipt < ApplicationRecord
  belongs_to :vendor, optional: true
  belongs_to :user
  has_many :items
end
