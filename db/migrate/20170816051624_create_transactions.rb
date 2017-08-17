class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :result
      t.integer :credit_card_number, :limit => 8
      t.references :invoice, foreign_key: true
      t.timestamps
    end
  end
end
