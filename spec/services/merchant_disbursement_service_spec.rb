require 'rails_helper'

RSpec.describe MerchantDisbursementService, type: :model do
  describe '#run' do
    let(:merchant) { create(:merchant) }
    let(:order) { create(:order, merchant: merchant) }

    it 'valid params' do
      expect {
        MerchantDisbursementService.new(merchant).run
      }.not_to raise_error
    end
  end
end