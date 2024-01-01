# == Schema Information
#
# Table name: merchants
#
#  id                     :bigint           not null, primary key
#  disbursement_frequency :integer          not null
#  email                  :string
#  id_key                 :string
#  live_on                :date             not null
#  minimum_monthly_fee    :decimal(10, 2)   default(0.0), not null
#  monthly_fee_payment    :decimal(10, 2)   default(0.0), not null
#  reference              :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  unique_reference  (reference) UNIQUE
#
require 'rails_helper'

RSpec.describe Merchant, type: :model do
  subject {
    described_class.new(disbursement_frequency: 1,
                        live_on: "2022-10-21",
                        reference: "my_merchant")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a live_on" do
    subject.live_on = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a reference" do
    subject.reference = nil
    expect(subject).to_not be_valid
  end
end
