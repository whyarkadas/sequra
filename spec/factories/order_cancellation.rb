# frozen_string_literal: true

FactoryBot.define do
  factory :order_cancellation, class: 'OrderCancellation' do
    amount { amount }
    creation_date { creation_date }
    id_key { "056d024481a9" }
    order
  end
end
