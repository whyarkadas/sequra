require 'rails_helper'

RSpec.describe CsvImport::MerchantImport do
  describe "#call" do
    context "Initiate with valid params" do
      it "import with successful Merchant count" do
        expect {
          CsvImport::MerchantImport.new(file_fixture('merchants.csv'), ';').call
        }.to change(Merchant, :count).by(10)
      end
    end
  end
end