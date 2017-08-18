class InvoiceItem < ApplicationRecord
  validates_prsence_of :unit_price, :quantity, :item_id, :invoice_id

  belongs_to :invoice
  belongs_to :item
end
