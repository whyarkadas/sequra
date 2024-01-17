require 'rails_helper'

RSpec.describe MerchantDisbursementService, type: :model do
  describe '#run for same day orders' do
    context 'orders with total amount less than 50' do
      let(:merchant) { create(:merchant_with_orders, orders_count: 5, orders_amount: 5) }

      it 'valid params' do
        expect {
          MerchantDisbursementService.new(merchant).run
        }.not_to raise_error
      end

      it 'disbursement count' do
        MerchantDisbursementService.new(merchant).run
        expect(Disbursement.all.size).to eq 1
        expect(Disbursement.first.amount.to_f).to eq 25.0
        expect(Disbursement.first.fee.to_f).to eq 0.25
        expect(Disbursement.first.monthly_fee.to_f).to eq 0.0
      end
    end

  #   context 'orders with total amount less than 300 more than 50' do
  #     let(:merchant) { create(:merchant_with_orders, orders_count: 5, orders_amount: 100) }
  #
  #     it 'valid params' do
  #       expect {
  #         MerchantDisbursementService.new(merchant).run
  #       }.not_to raise_error
  #     end
  #
  #     it 'disbursement count' do
  #       MerchantDisbursementService.new(merchant).run
  #       expect(Disbursement.all.size).to eq 1
  #       expect(Disbursement.first.amount.to_f).to eq 500.0
  #       expect(Disbursement.first.fee.to_f).to eq 4.75
  #       expect(Disbursement.first.monthly_fee.to_f).to eq 0.0
  #     end
  #   end
  #
  #   context 'orders with total amount more than 300' do
  #     let(:merchant) { create(:merchant_with_orders, orders_count: 5, orders_amount: 400) }
  #
  #     it 'valid params' do
  #       expect {
  #         MerchantDisbursementService.new(merchant).run
  #       }.not_to raise_error
  #     end
  #
  #     it 'disbursement count' do
  #       MerchantDisbursementService.new(merchant).run
  #       expect(Disbursement.all.size).to eq 1
  #       expect(Disbursement.first.amount.to_f).to eq 2000.0
  #       expect(Disbursement.first.fee.to_f).to eq 17.0
  #       expect(Disbursement.first.monthly_fee.to_f).to eq 0.0
  #     end
  #   end
  # end
  #
  # describe '#run for different day orders' do
  #   context 'orders with total amount less than 50' do
  #     let(:merchant) { create(:merchant_with_different_day_orders, orders_count: 10, orders_amount: 5) }
  #
  #     it 'valid params' do
  #       expect {
  #         MerchantDisbursementService.new(merchant).run
  #       }.not_to raise_error
  #     end
  #
  #     it 'disbursement count' do
  #       MerchantDisbursementService.new(merchant).run
  #       expect(Disbursement.all.size).to eq 2
  #       expect(Disbursement.all.inject(0) {|sum, d| sum + d.amount.to_f} ).to eq 50.0
  #       expect(Disbursement.all.inject(0) {|sum, d| sum + d.fee.to_f} ).to eq 0.50
  #       expect(Disbursement.all.inject(0) {|sum, d| sum + d.monthly_fee.to_f} ).to eq 0.0
  #     end
  #   end
  #
  #   context 'orders more than one month' do
  #     let(:merchant) { create(:merchant_with_different_day_orders, orders_count: 35, orders_amount: 5) }
  #
  #     it 'valid params' do
  #       expect {
  #         MerchantDisbursementService.new(merchant).run
  #       }.not_to raise_error
  #     end
  #
  #     it 'disbursement count' do
  #       MerchantDisbursementService.new(merchant).run
  #       expect(Disbursement.all.size).to eq 5
  #       expect(Disbursement.all.inject(0) {|sum, d| sum + d.monthly_fee.to_f} ).to eq 48.6
  #     end
  #   end

    context 'orders with total amount less than 50' do
      let(:merchant) { create(:merchant_with_orders_and_cancellations, orders_count: 5, orders_amount: 5,
                              order_cancellation_count: 2, cancellation_amount: 3) }

      it 'valid params' do
        expect {
          MerchantDisbursementService.new(merchant).run
        }.not_to raise_error
      end

      # it 'disbursement count' do
      #   MerchantDisbursementService.new(merchant).run
      #   expect(Disbursement.all.size).to eq 1
      #   expect(Disbursement.first.amount.to_f).to eq 25.0
      #   expect(Disbursement.first.fee.to_f).to eq 0.25
      #   expect(Disbursement.first.monthly_fee.to_f).to eq 0.0
      # end
    end

  end
end