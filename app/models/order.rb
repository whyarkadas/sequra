# == Schema Information
#
# Table name: orders
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
#
# Indexes
#
#  disbursement_id_index               (disbursement_id)
#  index_orders_on_merchant_reference  (merchant_reference)
#
class Order < ApplicationRecord
  belongs_to :merchant, class_name: "Merchant", optional: true, foreign_key: 'merchant_reference', primary_key: "reference", dependent: :destroy
  has_many :order_cancellations

  validates :merchant_reference, presence: true

  scope :not_disbursed, -> { where disbursement_id: nil }

  after_create :set_fee
  after_update_commit :set_fee, if: :saved_change_to_amount?

  FEE_LOWER_LIMIT = ENV.fetch('FEE_LOWER_LIMIT').to_f
  FEE_UPPER_LIMIT = ENV.fetch('FEE_UPPER_LIMIT').to_f
  FEE_LOWER_LIMIT_PERCENTAGE = ENV.fetch('FEE_LOWER_LIMIT_PERCENTAGE').to_f
  FEE_MEDIAN_LIMIT_PERCENTAGE = ENV.fetch('FEE_MEDIAN_LIMIT_PERCENTAGE').to_f
  FEE_UPPER_LIMIT_PERCENTAGE = ENV.fetch('FEE_UPPER_LIMIT_PERCENTAGE').to_f

  def set_fee
    update!(fee: calculate_fee)
  end

  #   1.00 % fee for orders with an amount strictly smaller than 50 €.
  #   0.95 % fee for orders with an amount between 50 € and 300 €.
  #   0.85 % fee for orders with an amount of 300 € or more.

  def calculate_fee
    if amount < FEE_LOWER_LIMIT
      fee = amount * FEE_LOWER_LIMIT_PERCENTAGE / 100
    else
      if amount >= FEE_LOWER_LIMIT && amount < FEE_UPPER_LIMIT
        fee = amount * FEE_MEDIAN_LIMIT_PERCENTAGE / 100
      else
        fee = amount * FEE_UPPER_LIMIT_PERCENTAGE / 100
      end
    end
    fee
  end
end
