class AddColumnInvoiceIdToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :invoice_id, :integer
  end
end
