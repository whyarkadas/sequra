# == Schema Information
#
# Table name: order_cancellations
#
#  id                 :bigint           not null, primary key
#  amount             :decimal(10, 2)   not null
#  creation_date      :date             not null
#  fee                :decimal(10, 2)   default(0.0)
#  id_key             :string
#  merchant_reference :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  disbursement_id    :integer
#  order_id           :integer
#
# Indexes
#
#  disbursement_id_cancellation_index               (disbursement_id)
#  index_order_cancellations_on_merchant_reference  (merchant_reference)
#
class OrderCancellation < ApplicationRecord
  belongs_to :merchant, class_name: "Merchant", optional: true, foreign_key: 'merchant_reference', primary_key: "reference", dependent: :destroy
  belongs_to :order, optional: false

  validates :merchant_reference, presence: true

  scope :not_disbursed, -> { where disbursement_id: nil }
end
