class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.favorite_merchant(customer_id)
    Merchant.joins(
      "INNER JOIN (" +
          Invoice.joins(:transactions)
              .where(invoices: {customer_id: customer_id}, transactions: {result: 'success'})
              .select("invoices.merchant_id, COUNT(invoices.merchant_id) AS frequency")
              .group("invoices.merchant_id")
              .order("frequency DESC")
              .limit(1).to_sql +
          ") invoice_transactions ON merchants.id = invoice_transactions.merchant_id"
    )
  end

  def self.favorite_customer(merch_id)
                  Customer.joins(invoices: :transactions)
                  .where(invoices: { merchant_id: merch_id }, transactions: {result: 'success'})
                  .group('customers.id')
                  .order('count(transactions) DESC')
                  .first
  end
end
