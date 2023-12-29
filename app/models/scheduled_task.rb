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
  # TODO: Validate :scheduled_at is in the future.
end
