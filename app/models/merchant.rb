# == Schema Information
#
# Table name: merchants
#
#  id                     :bigint           not null, primary key
#  disbursement_frequency :integer          not null
#  email                  :string
#  id_key                 :string
#  live_on                :date             not null
#  minimum_monthly_fee    :decimal(10, 2)   default(0.0), not null
#  monthly_fee_payment    :decimal(10, 2)   default(0.0), not null
#  reference              :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  unique_reference  (reference) UNIQUE
#
class Merchant < ApplicationRecord
  has_many :orders, class_name: "Order", foreign_key: 'merchant_reference', primary_key: "reference"
  has_many :order_cancellations, class_name: "OrderCancellation", foreign_key: 'merchant_reference', primary_key: "reference"
  has_many :disbursements

  has_many :not_disbursed_order_cancellations, -> { not_disbursed }, class_name: 'OrderCancellation',
           foreign_key: 'merchant_reference', primary_key: "reference"

  has_many :not_disbursed_orders, -> { not_disbursed }, class_name: 'Order',
           foreign_key: 'merchant_reference', primary_key: "reference"

  enum :disbursement_frequency, [:weekly, :daily]

  validates :reference, presence: true, uniqueness:true
  validates :live_on, presence: true

  after_create :add_scheduled_task

  def add_scheduled_task
    ScheduledTask.create!(scheduled_at: next_at, merchant_id:id)
  end

  def next_schedule_day
    self.daily? ? Date.tomorrow : Date.current + 7.days
  end

  def next_at
    next_schedule_day.beginning_of_day + 8.hours
  end

  def update_monthly_fee_payment(fee_payment)
    self.update!(monthly_fee_payment: monthly_fee_payment + fee_payment)
  end

  def disburse_all
    MerchantDisbursementService.new(self).run
  end

  def update_orders_disbursement(orders_to_disburse, disbursement_id)
    orders_to_disburse.each do |order|
      order.update(disbursement_id: disbursement_id)
    end
  end

  def is_first_disbursement_of_month(disbursement_date)
    return false if last_disbursements.nil?
    last_disbursements&.month != disbursement_date.month
  end

  def last_disbursements
    disbursements.order('creation_date DESC').first
  end
end
