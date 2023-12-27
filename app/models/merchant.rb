class Merchant < ApplicationRecord
  has_many :orders, class_name: "Order", foreign_key: 'merchant_reference', primary_key: "reference"

  enum :disbursement_frequency, [:weekly, :daily]

  validates :reference, presence: true, uniqueness:true
  validates :live_on, presence: true
end
