class ScheduledTaskJob < ApplicationJob
  def perform
    tasks = ScheduledTask.where("scheduled_at <= ?", Time.now.utc)

    tasks.each do |task|
      DisbursementJob.perform(task)
    end
  end
end
