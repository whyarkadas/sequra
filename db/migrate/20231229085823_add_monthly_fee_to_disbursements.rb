class AddMonthlyFeeToDisbursements < ActiveRecord::Migration[7.1]
  def change
    add_column :disbursements, :monthly_fee, :decimal, default: 0, precision: 10, scale: 2
  end
end
