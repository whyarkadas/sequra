# frozen_string_literal: true

FactoryBot.define do
  factory :merchant, class: 'Merchant' do
    sequence(:reference) { |n| "treutel_schumm_fadel_" + n.to_s }
    email { "info@treutel-schumm-and-fadel.com" }
    live_on { "2023-01-01" }
    disbursement_frequency { :weekly }
    minimum_monthly_fee { 50.0 }
    id_key { "2ae89f6d-e210-4993-b4d1-0bd2d279da62" }
    monthly_fee_payment { 0 }

    factory :merchant_with_orders do
      transient do
        orders_count { 5 }
      end
      transient do
        orders_amount { 10 }
      end

      transient do
        creation_date { "2023-01-01" }
      end

      after(:create) do |merchant, evaluator|
        create_list(:order, evaluator.orders_count, merchant: merchant,
                    amount: evaluator.orders_amount, creation_date: evaluator.creation_date)

        merchant.reload
      end
    end

    factory :merchant_with_different_day_orders do
      transient do
        orders_count { 5 }
      end
      transient do
        orders_amount { 10 }
      end
      transient do
        creation_date { "2023-01-01" }
      end

      after(:create) do |merchant, evaluator|
        (1..evaluator.orders_count).each do |index|
          create(:order, merchant: merchant, amount: evaluator.orders_amount,
                 creation_date: DateTime.parse(evaluator.creation_date, "%Y-%m-%d") + index.days)
        end
        merchant.reload
      end
    end

    factory :merchant_with_orders_and_cancellations do
      transient do
        orders_count { 5 }
      end
      transient do
        orders_amount { 10 }
      end
      transient do
        order_cancellation_count { 2 }
      end
      transient do
        cancellation_amount { 3 }
      end
      transient do
        creation_date { "2023-01-01" }
      end

      after(:create) do |merchant, evaluator|
        create_list(:order_with_cancellations, evaluator.orders_count, merchant: merchant,
                    amount: evaluator.orders_amount, creation_date: evaluator.creation_date,
                    order_cancellation_count: 1, cancellation_amount: 1)

        merchant.reload
      end
      # after(:create) do |merchant, evaluator|
      #   create_list(:order_cancellation, evaluator.order_cancellation_count, merchant: merchant, order: order,
      #               amount: evaluator.cancellation_amount, creation_date: evaluator.creation_date)
      #
      #   merchant.reload
      # end
    end

  end
end
