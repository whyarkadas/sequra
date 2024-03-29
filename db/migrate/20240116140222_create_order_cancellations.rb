class CreateOrderCancellations < ActiveRecord::Migration[7.1]
  def change
    create_table :order_cancellations do |t|
      t.string :merchant_reference, null: false, index: true
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.date :creation_date, null: false
      t.integer :disbursement_id, index: { name: 'disbursement_id_cancellation_index' }
      t.string :id_key
      t.decimal :fee, default: 0, precision: 10, scale: 2

      t.timestamps
    end
  end
end
