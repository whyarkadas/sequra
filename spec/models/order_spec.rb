# == Schema Information
#
# Table name: orders
#
#  id                 :bigint           not null, primary key
#  amount             :decimal(10, 2)   not null
#  creation_date      :date             not null
#  fee                :decimal(10, 2)   default(0.0)
#  id_key             :string
#  merchant_reference :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  disbursement_id    :integer
#
# Indexes
#
#  disbursement_id_index               (disbursement_id)
#  index_orders_on_merchant_reference  (merchant_reference)
#
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
