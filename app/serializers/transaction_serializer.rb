class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :credit_card_number, :result, :invoice_id, :invoice_status
  belongs_to :invoice

  def invoice_status
    object.invoice.status
  end
end
