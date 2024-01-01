class DisbursementService
  def initialize(task)
    @task = task
  end

  def run
    merchant = Merchant.find(@task.merchant_id)
    merchant.disburse_all

    @task.update(scheduled_at: merchant.next_at)
  end
end