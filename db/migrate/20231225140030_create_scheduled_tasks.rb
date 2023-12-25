class CreateScheduledTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :scheduled_tasks do |t|
      t.integer :merchant_id,  null: false, index: { unique: true, name: 'unique_merchant_task' }
      t.date :scheduled_at

      t.timestamps
    end
  end
end
