class DisbursementJob < ApplicationJob
  def perform(task)
    DisbursementService.new(task).run
  end
end
