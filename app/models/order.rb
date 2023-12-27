class Order < ApplicationRecord
  belongs_to :merchant, class_name: "Merchant", optional: true, foreign_key: 'merchant_reference', primary_key: "reference", dependent: :destroy

  validates :merchant_reference, presence: true
end
