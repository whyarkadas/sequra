# frozen_string_literal: true

FactoryBot.define do
  # factory :order, class: 'Order' do
  #   merchant
  #   amount { 61.74 }
  #   creation_date {"2023-01-01"}
  #   id_key { "056d024481a9" }
  # end

  # factory :order, class: 'Order' do
  #   trait :merchant do
  #     merchant_reference  merchant.reference
  #   end
  #   merchant_reference { "treutel_schumm_fadel" }
  #   amount { 61.74 }
  #   creation_date {"2023-01-01"}
  #   id_key { "056d024481a9" }
  # end
  #
  #
  factory :order, class: 'Order' do
  #   amount { amount }
  #   creation_date { creation_date }
  #   id_key { "056d024481a9" }
  # end

  factory :order_with_cancellations, class: 'Order' do
    amount { amount }
    creation_date { creation_date }
    id_key { "056d024481a9" }


    transient do
      order_cancellation_count { 1 }
    end
    transient do
      cancellation_amount { 1 }
    end

    after(:create) do |merchant, evaluator|
      create_list(:order_cancellation, evaluator.order_cancellation_count, order: order,
                  amount: evaluator.cancellation_amount)
      merchant.reload
    end
  end
  end
end
