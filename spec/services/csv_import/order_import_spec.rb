require 'rails_helper'

RSpec.describe CsvImport::OrderImport do
  describe "#call" do
    let(:merchant) { create(:merchant) }
    context "Initiate with valid params" do
      it "import with successful Order count" do
        expect {
          CsvImport::OrderImport.new(file_fixture('orders.csv'), ',').call
        }.to change(Order, :count).by(10)
      end
    end
  end
end