class Merchant < ApplicationRecord
  has_many :orders

  enum :disbursement_frequency, [:weekly, :daily]

  validates :reference, presence: true
  validates :live_on, presence: true
end
