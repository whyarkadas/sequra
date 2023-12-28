require 'rails_helper'

RSpec.describe DisbursementService, type: :model do
  describe '#run' do
    let(:merchant) { create(:merchant) }
    let(:task) { create(:scheduled_task, merchant: merchant) }
    let(:order) { create(:order) }

    it 'valid params' do
      expect {
        DisbursementService.new(task).run
      }.not_to raise_error
    end

      #expect(order.disbursement_id).not_to be_nil
    it 'valid params with entity count' do
      expect {
        DisbursementService.new(task).run
      }.to change(Disbursement, :count).by(1)
    end

      # TODO: check task scheduled_at next
      # Check order disbursement id
  end
end