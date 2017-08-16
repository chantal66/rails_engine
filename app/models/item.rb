class Item < ApplicationRecord
  validates_presence_of :name, :merchant_id, :description
  belongs_to :merchant
end
