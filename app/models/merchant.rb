class Merchant < ApplicationRecord
  validates_presence_of :name, presence: true

  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

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

  def self.favorite_customer(merchant_id)
    Customer.joins(invoices: :transactions)
    .where(invoices: { merchant_id: merchant_id }, transactions: {result: 'success'})
    .group('customers.id')
    .order('count(transactions) DESC')
    .first
  end

  def self.customers_with_pending_invoices(id)
    Merchant.find_by_sql [
     "WITH pending_invoices as (SELECT i.id inv_id, MAX(t.id) max FROM invoices i INNER JOIN transactions t ON i.id = t.invoice_id GROUP BY 1
      EXCEPT
      SELECT i.id, MAX(t.id) FROM invoices i INNER JOIN transactions t ON i.id = t.invoice_id WHERE result = 'success' GROUP BY 1)
      SELECT c.id, c.first_name, c.last_name
      FROM merchants m
      INNER JOIN invoices i ON i.merchant_id = m.id
      INNER JOIN pending_invoices ON pending_invoices.inv_id = i.id
      INNER JOIN customers c ON i.customer_id = c.id
      WHERE m.id = #{id}
      GROUP BY 1,2,3;"
     ]
  end

  def self.total_revenue(date=nil)
    select("merchants.id")
      .joins(invoices: [:invoice_items, :transactions])
      .where("transactions.result ='success'")
      .where("invoices.created_at=?", date)
      .group('id')
      .sum("invoice_items.unit_price * invoice_items.quantity")
  end
end
