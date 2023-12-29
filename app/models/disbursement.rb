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
#  unique_merchant  (merchant_id) UNIQUE
#
class Disbursement < ApplicationRecord
  belongs_to :merchant, optional: false
  has_many :orders

  # TODO: Add month and year validations in limit
end
