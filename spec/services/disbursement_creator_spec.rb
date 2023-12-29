require 'rails_helper'

RSpec.describe DisbursementCreator, type: :model do
  describe '#run' do
    let(:merchant) { create(:merchant) }
    let(:disbursement_amount) { 25.00 }
    let(:disbursement_fee) { 3.00 }
    let(:monthly_fee) { 5.00 }

    it 'valid params' do
      expect {
        DisbursementCreator.new(disbursement_amount, disbursement_fee, monthly_fee, merchant.id).run
      }.to change(Disbursement, :count).by(1)
    end

    it 'valid params, attribute check' do
      disbursement = DisbursementCreator.new(disbursement_amount, disbursement_fee, monthly_fee, merchant.id).run
      expect(disbursement.amount).to eq(disbursement_amount)
    end

    # TODO: Add failing create test here.
    #
    # TODO: Add monthly fee test here.
  end
end