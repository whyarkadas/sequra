require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:merchant) { create(:merchant) }
  let(:order_params) {
    {
      merchant_reference: "treutel_schumm_fadel",
      amount: 20.00,
      creation_date: "2022-01-01",
      id_key:"056d024481a9"
    }
  }

  describe "#calculate_fee" do
    context 'after create' do
      it "amount less than 50" do
        order = Order.create(order_params)
        expect(order.fee.to_f).to eq 0.20
      end
      it "amount more than 50 less than 300" do
        order_params[:amount] = 100
        order = Order.create(order_params)
        expect(order.fee.to_f).to eq 0.95
      end
      it "amount more than 300" do
        order_params[:amount] = 1000
        order = Order.create(order_params)
        expect(order.fee.to_f).to eq 8.50
      end
    end

    context 'after update' do
      it "amount less than 50" do
        order = Order.create(order_params)
        expect(order.fee.to_f).to eq 0.20
      end
      it "amount than 50 less than 300" do
        order_params[:amount] = 100
        order = Order.create(order_params)
        expect(order.fee.to_f).to eq 0.95
      end
      it "amount more than 300" do
        order_params[:amount] = 1000
        order = Order.create(order_params)
        expect(order.fee.to_f).to eq 8.50
      end
    end
  end
end
