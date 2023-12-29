class ApplicationJob < ActiveJob::Base
  include ActiveSupport::Rescuable

  queue_as :default
  # Automatically retry jobs that encountered a deadlock
  retry_on ActiveRecord::Deadlocked

  rescue_from ActiveRecord::RecordNotFound do |error|
    Rails.logger.error "ActiveRecord::RecordNotFound on Job: #{error}"
    retry_job wait: 5.minutes
  end
end
