class Transaction < ApplicationRecord
  belongs_to :invoice
  scope :successful, -> {where(result: ‘success’)}
  scope :failed, -> {where(result: 'failed')}

end
