# == Schema Information
#
# Table name: scheduled_tasks
#
#  id           :bigint           not null, primary key
#  scheduled_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  merchant_id  :integer          not null
#
# Indexes
#
#  unique_merchant_task  (merchant_id) UNIQUE
#
class ScheduledTask < ApplicationRecord
  belongs_to :merchant, optional: false
  validate :scheduled_at_future

  def scheduled_at_future
    if scheduled_at < DateTime.now
      errors.add(:scheduled_at, "must be later than current time")
    end
  end
end
