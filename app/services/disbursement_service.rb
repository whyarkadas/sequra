class DisbursementService
  def initialize(task)
    @task = task
  end

  def run
    merchant = Merchant.find(@task.merchant_id)
    merchant.disburse

    # TODO: Check if first day of mont and check minimum monthly_fee_payment logic.
    @task.update(scheduled_at: merchant.next_at)
  end
end