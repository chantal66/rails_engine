class Merchant < ApplicationRecord
  validates_presence_of :name, presence: true

  has_many :invoices
  has_many :items

  def self.revenue_on_date(date)
    Invoice.joins(:invoice_items, :transactions)
        .where(invoices: {created_at: date}, transactions: {result: 'success'})
        .select("invoices.created_at::timestamp::date AS date, SUM(invoice_items.quantity*invoice_items.unit_price::numeric)/100 AS total_revenue")
        .group("date")
  end

  def self.revenue_for_one_merchant(id)
    value = Merchant.find_by_sql [
                                     "SELECT merchants.name merchant_name, ROUND(SUM(invoice_items.quantity * invoice_items.unit_price / 100.00),2) AS revenue
      FROM merchants
      INNER JOIN items ON merchants.id = items.merchant_id
      INNER JOIN invoice_items ON items.id = invoice_items.item_id
      INNER JOIN invoices ON invoices.id = invoice_items.invoice_id
      INNER JOIN transactions ON transactions.invoice_id = invoices.id
      WHERE merchants.id =  #{id} AND transactions.result = 'success'
      GROUP BY merchant_name" ]
    value.first
  end

  def self.revenue_for_one_merchant_by_date(id, date)
    value = Merchant.find_by_sql [
      "SELECT merchants.name merchant_name, invoices.updated_at AS date, ROUND(SUM(invoice_items.quantity * invoice_items.unit_price / 100.00),2) AS revenue
      FROM merchants
      INNER JOIN items ON merchants.id = items.merchant_id
      INNER JOIN invoice_items ON items.id = invoice_items.item_id
      INNER JOIN invoices ON invoices.id = invoice_items.invoice_id
      INNER JOIN transactions ON transactions.invoice_id = invoices.id
      WHERE merchants.id = #{id} AND invoices.updated_at = '#{date}' AND transactions.result = 'success'
      GROUP BY merchant_name, date" ]
    value.first
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
