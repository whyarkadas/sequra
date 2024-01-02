# frozen_string_literal: true

FactoryBot.define do
  factory :order, class: 'Order' do
    merchant_reference { "treutel_schumm_fadel" }
    amount { 61.74 }
    creation_date {"2023-01-01"}
    id_key { "056d024481a9" }
  end

  factory :merchant_order, class: 'Order' do
    trait :merchant do
      association :merchant, merchant
    end
    amount { 61.74 }
    creation_date {"2023-01-01"}
    id_key { "056d024481a9" }
  end
end
