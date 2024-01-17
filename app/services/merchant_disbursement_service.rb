# frozen_string_literal: true

class MerchantDisbursementService
  attr_accessor :merchant

  def initialize(merchant)
    @merchant = merchant
  end

  def run
    start_date = merchant.last_disbursements&.creation_date || merchant.live_on.beginning_of_day

    loop do
      end_date = start_date + (merchant.daily? ? 1.day : 1.week)

      orders_to_disburse = merchant.not_disbursed_orders.where(creation_date: start_date..end_date)
      canceled_orders_to_disburse = merchant.not_disbursed_order_cancellations.where(creation_date: start_date..end_date)

      if orders_to_disburse.present? || canceled_orders_to_disburse.present?
        disburse_orders(orders_to_disburse, canceled_orders_to_disburse, end_date)
      end

      start_date = end_date
      break if start_date > Date.today
    end
  end

  def disburse_orders(orders_to_disburse, canceled_orders_to_disburse, end_date)
    disbursement_amount = 0
    disbursement_fee = 0
    monthly_fee = 0

    orders_to_disburse.each do |order|
      disbursement_amount += order.amount
      disbursement_fee += order.fee
    end

    canceled_orders_to_disburse.each do |cancelled_order|
      disbursement_amount -= cancelled_order.amount
      disbursement_fee -= cancelled_order.fee
    end

    if merchant.is_first_disbursement_of_month(end_date)
      if merchant.minimum_monthly_fee > merchant.monthly_fee_payment
        monthly_fee = merchant.minimum_monthly_fee - merchant.monthly_fee_payment
      end

      merchant.update!(monthly_fee_payment: 0)
    end

    disbursement = DisbursementCreator.new(disbursement_amount.to_f, disbursement_fee.to_f,
                                           monthly_fee.to_f, merchant.id, end_date).run

    if disbursement
      merchant.update_orders_disbursement(orders_to_disburse, disbursement.id)
      merchant.update_monthly_fee_payment(disbursement_fee)
    else
      Rails.logger.error "Can not create disbursement for merchant: #{id}"
    end
  end
end
