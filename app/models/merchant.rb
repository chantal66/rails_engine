class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items


  def self.revenue_for_one_merchant(merchant_id)
    Invoice.joins(:invoice_items, :transactions)
        .joins(:invoice_items)
        .where("invoices.merchant_id = ? AND transactions.result = 'success'", merchant_id)
        .select("SUM(invoice_items.quantity*invoice_items.unit_price::numeric)/100 AS revenue")
        .group(:merchant_id)
  end


end
