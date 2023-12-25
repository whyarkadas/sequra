class Merchant < ApplicationRecord
  has_many :orders

  enum :disbursement_frequency, [:weekly, :daily]
end
