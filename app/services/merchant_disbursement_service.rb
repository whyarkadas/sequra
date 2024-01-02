# frozen_string_literal: true

class MerchantDisbursementService
  attr_accessor :merchant

  def initialize(merchant)
    @merchant = merchant
  end

  def run
    start_date = merchant.last_disbursements&.creation_date || merchant.live_on.beginning_of_day

    pp merchant.orders.all

    loop do
      end_date = start_date + (merchant.daily? ? 1.day : 1.week)

      puts start_date
      puts end_date

      orders_to_disburse = merchant.orders.where(creation_date: start_date..end_date)
      puts "orders_to_disburse"
      puts orders_to_disburse

      unless orders_to_disburse.empty?
        disburse_orders(orders_to_disburse, end_date)
      end

      start_date = end_date
      break if start_date > Date.today
    end
  end

  def disburse_orders(orders_to_disburse, end_date)
    disbursement_amount = 0
    disbursement_fee = 0
    monthly_fee = 0

    orders_to_disburse.each do |order|
      disbursement_amount += order.amount
      disbursement_fee += order.fee
    end

    if merchant.is_first_disbursement_of_month
      if merchant.minimum_monthly_fee > merchant.monthly_fee_payment
        monthly_fee = merchant.minimum_monthly_fee - merchant.monthly_fee_payment
      end

      self.update!(monthly_fee_payment: 0)
    end

    disbursement = DisbursementCreator.new(disbursement_amount.to_f, disbursement_fee.to_f, monthly_fee.to_f, id, end_date).run

    if disbursement
      merchant.update_orders_disbursement(orders_to_disburse, disbursement.id)
      merchant.update_monthly_fee_payment(disbursement_fee)
    else
      Rails.logger.error "Can not create disbursement for merchant: #{id}"
    end
  end
end
