class CreateMerchants < ActiveRecord::Migration[7.1]
  def change
    create_table :merchants do |t|
      t.string :reference, null: false, index: { unique: true, name: 'unique_reference' }
      t.string :email
      t.date :live_on, null: false
      t.integer :disbursement_frequency, null: false
      t.decimal :minimum_monthly_fee, default: 0, null: false, precision: 10, scale: 2
      t.string :id_key
      t.decimal :monthly_fee_payment, default: 0, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
