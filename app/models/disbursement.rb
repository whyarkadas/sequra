class Disbursement < ApplicationRecord
  belongs_to :merchant, optional: false
  has_many :orders

  # TODO: Add month and year validations in limit
end
