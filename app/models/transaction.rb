class Transaction < ApplicationRecord
  validates_presence_of :result, :credit_card_number, :invoice_id
  belongs_to :invoice
  scope :successful, -> {where(result: ‘success’)}
  scope :failed, -> {where(result: 'failed')}

end
