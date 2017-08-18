class Merchant < ApplicationRecord
  validates_presence_of :name, presence: true

  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.revenue_on_date(date)
    Invoice.joins(:invoice_items, :transactions)
        .where(invoices: {created_at: date}, transactions: {result: 'success'})
        .select("invoices.created_at::timestamp::date AS date, SUM(invoice_items.quantity*invoice_items.unit_price::numeric)/100 AS total_revenue")
        .group("date")
  end

  def self.revenue_for_merchant(merchant_id)
    Invoice.joins(:invoice_items, :transactions)
        .joins(:invoice_items)
        .where("invoices.merchant_id = ? AND transactions.result = 'success'", merchant_id)
        .select("SUM(invoice_items.quantity*invoice_items.unit_price::numeric)/100 AS revenue")
        .group(:merchant_id)
  end

  def self.most_revenue(quantity=nil)
    Merchant.select("merchants.*, sum(unit_price * quantity) AS revenue")
            .joins(invoices: :invoice_items)
            .group("id")
            .limit(quantity)
            .order("revenue DESC")
  end

  def self.revenue_for_merchant_by_date(merchant_id, date)
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
