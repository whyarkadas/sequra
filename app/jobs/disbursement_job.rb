class DisbursementJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Hello DisbursementJob" * 20
  end
end
