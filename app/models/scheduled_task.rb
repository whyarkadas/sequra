class ScheduledTask < ApplicationRecord
  belongs_to :merchant, optional: false
  # TODO: Validate :scheduled_at is in the future.
end
