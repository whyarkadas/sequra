class Order < ApplicationRecord
  belongs_to :merchant, class_name: :Merchant, foreign_key: :merchant_reference
end
