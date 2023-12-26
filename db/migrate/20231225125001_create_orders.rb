class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :merchant_id, null: false, index: true
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.date :creation_date, null: false
      t.integer :disbursement_id, index: { name: 'disbursement_id_index' }
      t.string :id_key
      t.decimal :fee, default: 0, precision: 10, scale: 2

      t.timestamps
    end
  end
end
