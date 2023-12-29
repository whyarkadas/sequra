require 'rails_helper'

RSpec.describe Reports::BuildDisbursementReport do
  describe "#run" do
    include ActiveJob::TestHelper

    subject(:service) { described_class.new }

    it 'queues the job' do
      expect { service.run }
        .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    after do
      clear_enqueued_jobs
      clear_performed_jobs
    end
  end
end