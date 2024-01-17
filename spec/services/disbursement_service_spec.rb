require 'rails_helper'

RSpec.describe DisbursementService, type: :model do
  describe '#run' do
    let!(:merchant) { create(:merchant) }
    let!(:scheduled_task) { create(:scheduled_task, merchant: merchant) }

    # let(:merchant) { create(:merchant) }
    # let(:scheduled_time) {  DateTime.now + 1.day }
    # let(:scheduled_task) { ScheduledTask.create!(merchant_id: merchant.id, scheduled_at: scheduled_time) }

    # before :each do
    #   pp ScheduledTask.all.size
    # end


    it 'valid params' do
      expect {
        DisbursementService.new(scheduled_task).run
      }.not_to raise_error
    end

    # expect(order.disbursement_id).not_to be_nil
    # it 'valid params with entity count' do
    #   expect {
    #     DisbursementService.new(task).run
    #   }.to change(Disbursement, :count).by(1)
    # end

      # TODO: check task scheduled_at next
  end
end