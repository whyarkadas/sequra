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
require 'rails_helper'

RSpec.describe ScheduledTask, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
