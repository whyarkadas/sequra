class Merchant < ApplicationRecord
  has_many :orders, class_name: "Order", foreign_key: 'merchant_reference', primary_key: "reference"
  has_many :not_disbursed_orders, -> { not_disbursed }, class_name: 'Order',
           foreign_key: 'merchant_reference', primary_key: "reference"

  enum :disbursement_frequency, [:weekly, :daily]

  validates :reference, presence: true, uniqueness:true
  validates :live_on, presence: true

  def next_schedule_day
    self.daily? ? Date.tomorrow : Date.current + 7.days
  end

  def next_at
    next_schedule_day.beginning_of_day + 8.hours
  end

  def update_monthly_fee_payment(fee_payment)
    self.update!(monthly_fee_payment: monthly_fee_payment + fee_payment)
  end

  def disburse
    disbursement_amount = 0
    disbursement_fee = 0

    not_disbursed_orders.each do |order|
      disbursement_amount += order.amount
      disbursement_fee += order.amount
    end

    disbursement = DisbursementCreator.new(disbursement_amount, disbursement_fee, id).run

    if disbursement
      update_not_disbursed_orders(disbursement.id)
      update_monthly_fee_payment(disbursement_fee)
    else
      Rails.logger.error "Can not create disbursement for merchant: #{id}"
    end
  end

  def update_not_disbursed_orders(disbursement_id)
    not_disbursed_orders.each do |order|
      order.update(disbursement_id: disbursement_id)
    end
  end
end
