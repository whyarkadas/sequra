require 'rails_helper'

RSpec.describe Reports::RunDisbursementReport, type: :model do
  describe '#run' do
    let(:merchant) { create(:merchant) }
    let(:task) { create(:scheduled_task, merchant: merchant) }
    let(:order) { create(:order) }

    subject(:service) { described_class.new }

    it 'valid params' do
      expect {
        service.run
      }.not_to raise_error
    end

    # TODO: Add result check test.
  end
end