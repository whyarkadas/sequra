# frozen_string_literal: true

FactoryBot.define do
  factory :order, class: 'Order' do
    # TODO: Add associations here.
    merchant_id { 1 }
    amount { 61.74 }
    creation_date {"2023-01-01"}
    id_key { "056d024481a9" }
  end
end
