class Merchant < ApplicationRecord
  has_many :orders, class_name: "Order", foreign_key: 'merchant_reference', primary_key: "reference"
  has_many :not_disbursed_orders, -> { not_disbursed }, class_name: 'Order',
           foreign_key: 'merchant_reference', primary_key: "reference"

  enum :disbursement_frequency, [:weekly, :daily]

  validates :reference, presence: true, uniqueness:true
  validates :live_on, presence: true

  def next_schedule_day
    disbursement_frequency.daily? ? Date.tomorrow : Date.current + 7.days
  end

  def update_monthly_fee_payment(fee_payment)
    self.update!(monthly_fee_payment: monthly_fee_payment + fee_payment)
  end
end
