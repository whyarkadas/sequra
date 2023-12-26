# frozen_string_literal: true

FactoryBot.define do
  factory :merchant, class: 'Merchant' do
    reference { "treutel_schumm_fadel"}
    email { "info@treutel-schumm-and-fadel.com" }
    live_on { "2022-01-01" }
    disbursement_frequency { :weekly }
    minimum_monthly_fee { 29.0 }
    id_key { "2ae89f6d-e210-4993-b4d1-0bd2d279da62" }
    monthly_fee_payment { 0 }
  end
end
