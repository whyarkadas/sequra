# == Schema Information
#
# Table name: scheduled_tasks
#
#  id           :bigint           not null, primary key
#  scheduled_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  merchant_id  :integer          not null
#
# Indexes
#
#  unique_merchant_task  (merchant_id) UNIQUE
#
require 'rails_helper'

RSpec.describe ScheduledTask, :type => :model do
  let(:merchant) { create(:merchant) }
  let(:scheduled_time) {  DateTime.now + 1.day }
  subject {
    described_class.new(merchant_id: merchant.id,
                        scheduled_at: scheduled_time)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a merchant_id" do
    subject.merchant_id = nil
    expect(subject).to_not be_valid
  end
  #
  it "is not valid with scheduled_at before now" do
    subject.scheduled_at = DateTime.now - 1.day
    expect(subject).to_not be_valid
  end
end