class DisbursementService
  def initialize(task)
    @task = task
  end

  def run
    merchant = Merchant.find(@task.merchant_id)
    merchant.disburse

    @task.update(scheduled_at: merchant.next_at)
  end
end