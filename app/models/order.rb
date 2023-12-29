class Order < ApplicationRecord
  belongs_to :merchant, class_name: "Merchant", optional: true, foreign_key: 'merchant_reference', primary_key: "reference", dependent: :destroy

  validates :merchant_reference, presence: true

  scope :not_disbursed, -> { where disbursement_id: nil }

  after_create :set_fee
  after_update_commit :set_fee, if: :saved_change_to_amount?

  # TODO: Move these to ENV.
  FEE_LOWER_LIMIT = 50
  FEE_UPPER_LIMIT = 300
  FEE_LOWER_LIMIT_PERCENTAGE = 1.00
  FEE_MEDIAN_LIMIT_PERCENTAGE = 0.95
  FEE_UPPER_LIMIT_PERCENTAGE = 0.85

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
