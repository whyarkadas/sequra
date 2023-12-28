class DisbursementJob < ApplicationJob
  def perform(task)
    merchant_id = task.merchant_id
    merchant = Merchant.find(merchant_id)

    disbursement_amount = 0
    disbursement_fee = 0

    merchant.not_disbursed_orders.each do |order|
      disbursement_amount += order.amount
      disbursement_fee += order.amount
    end

    disbursement = Disbursement.new(
        creation_date: DateTime.today,
        amount: disbursement_amount,
        fee: disbursement_fee,
        year: Date.current.year,
        month: Date.current.month,
        merchant_id: merchant_id
    )

    if disbursement.save!
      order.update(disbursement_id: disbursement.id)
      merchant.update_monthly_fee_payment(disbursement_fee)
    else
      # TODO: Add logging here.
    end

    # TODO: Check if first day of mont and check minimum monthly_fee_payment logic.
    #
    next_at = merchant.next_schedule_day.beginning_of_day + 8.hours
    task.update(scheduled_at: next_at)
  end
end
