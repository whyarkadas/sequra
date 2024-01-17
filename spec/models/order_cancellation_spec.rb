# == Schema Information
#
# Table name: order_cancellations
#
#  id                 :bigint           not null, primary key
#  amount             :decimal(10, 2)   not null
#  creation_date      :date             not null
#  fee                :decimal(10, 2)   default(0.0)
#  id_key             :string
#  merchant_reference :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  disbursement_id    :integer
#  order_id           :integer
#
# Indexes
#
#  disbursement_id_cancellation_index               (disbursement_id)
#  index_order_cancellations_on_merchant_reference  (merchant_reference)
#
require 'rails_helper'

RSpec.describe OrderCancellation, type: :model do
  let(:merchant) { create(:merchant) }
  let(:order) { create(:order, merchant: merchant) }

  subject {
    described_class.new(merchant_reference: merchant.reference,
                        amount: 20.00,
                        creation_date: "2022-01-01",
                        id_key:"056d024481a9",
                        order_id: order.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
