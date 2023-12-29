# == Schema Information
#
# Table name: disbursements
#
#  id            :bigint           not null, primary key
#  amount        :decimal(10, 2)   default(0.0), not null
#  creation_date :date
#  fee           :decimal(10, 2)   default(0.0), not null
#  month         :integer          not null
#  monthly_fee   :decimal(10, 2)   default(0.0)
#  year          :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  merchant_id   :integer          not null
#
# Indexes
#
#  disburse_merchant  (merchant_id)
#
require 'rails_helper'

RSpec.describe Disbursement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
