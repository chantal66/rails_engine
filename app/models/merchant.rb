class Merchant < ApplicationRecord
  validates_presence_of :name, presence: true

  has_many :invoices
  has_many :items


  def self.revenue_for_one_merchant(merchant_id)
    Invoice.joins(:invoice_items, :transactions)
        .joins(:invoice_items)
        .where("invoices.merchant_id = ? AND transactions.result = 'success'", merchant_id)
        .select("SUM(invoice_items.quantity*invoice_items.unit_price::numeric)/100 AS revenue")
        .group(:merchant_id)
  end

  def self.revenue_for_one_merchant_by_date(merchant_id, date)
    Invoice.joins(:invoice_items, :transactions)
        .joins(:invoice_items)
        .where("invoices.merchant_id = ? AND transactions.result = 'success' AND invoices.created_at = ?", merchant_id, date)
        .select("SUM(invoice_items.quantity*invoice_items.unit_price::numeric)/100 AS revenue")
        .group(:merchant_id)
  end

  def self.most_items(quantity = 5)
    select("merchants.*, sum(invoice_items.quantity) AS items_sold")
        .joins(invoices: [:invoice_items, :transactions])
        .where(transactions: { result: 'success' })
        .group(:id)
        .order("items_sold DESC")
        .limit(quantity)
  end

end
