class CreateDisbursements < ActiveRecord::Migration[7.1]
  def change
    create_table :disbursements do |t|
      t.integer :merchant_id, null: false, index: { name: 'disburse_merchant' }
      t.decimal :amount, default: 0, null: false, precision: 10, scale: 2
      t.date :creation_date
      t.decimal :fee, default: 0, null: false, precision: 10, scale: 2
      t.integer :year, null: false
      t.integer :month, null: false

      t.timestamps
    end
  end
end
