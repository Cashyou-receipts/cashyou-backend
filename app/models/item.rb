class Item < ApplicationRecord
  belongs_to :receipt
  belongs_to :vendor
end
