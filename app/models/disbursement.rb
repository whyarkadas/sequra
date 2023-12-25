class Disbursement < ApplicationRecord
  belongs_to :merchant
  has_many :orders

  # TODO: Check this ?
  enum :month => Date::MONTHNAMES
end
