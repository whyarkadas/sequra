# frozen_string_literal: true
FactoryBot.define do
  factory :scheduled_task, class: 'ScheduledTask' do
    # trait :merchant do
    #   association :merchant, merchant
    # end
    merchant
    scheduled_at { Time.now + 1.hour }
    # association :merchant, merchant


    # factory :scheduled_task_with_merchant do
    #   after(:create) do |scheduled_task, evaluator|
    #     create(:merchant, scheduled_task: scheduled_task)
    #
    #     scheduled_task.reload
    #   end
    # end
  end
end