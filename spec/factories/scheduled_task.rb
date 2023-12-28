# frozen_string_literal: true
FactoryBot.define do
  factory :scheduled_task, class: 'ScheduledTask' do
    trait :merchant do
      association :merchant, merchant
    end

    scheduled_at { Time.now - 1.hour }
  end
end