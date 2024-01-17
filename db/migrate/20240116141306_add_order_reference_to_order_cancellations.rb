class AddOrderReferenceToOrderCancellations < ActiveRecord::Migration[7.1]
  def change
    add_column :order_cancellations, :order_id, :integer
  end
end
