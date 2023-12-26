require 'rails_helper'

RSpec.describe "/merchants", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Merchant. As you add validations to Merchant, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      reference:"treutel_schumm_fadel",
      email: "info@treutel-schumm-and-fadel.com",
      live_on: "2022-01-01",
      disbursement_frequency: :weekly,
      minimum_monthly_fee: 29.0,
      id_key: "2ae89f6d-e210-4993-b4d1-0bd2d279da62",
      monthly_fee_payment: 0
    }
  }

  let(:invalid_attributes) {
    {
      email: "info@treutel-schumm-and-fadel.com",
      live_on: "2022-01-01",
      disbursement_frequency: :weekly,
      minimum_monthly_fee: 29.0,
      id_key: "2ae89f6d-e210-4993-b4d1-0bd2d279da62",
      monthly_fee_payment: 0
    }
  }

  let(:valid_headers) {
    {"Content-Type" => "application/json"}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Merchant.create! valid_attributes
      get merchants_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      merchant = Merchant.create! valid_attributes
      get merchant_url(merchant), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Merchant" do
        expect {
          post merchants_url,
               params: { merchant: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Merchant, :count).by(1)
      end

      it "renders a JSON response with the new merchant" do
        post merchants_url,
             params: { merchant: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Merchant" do
        expect {
          post merchants_url,
               params: { merchant: invalid_attributes }, as: :json
        }.to change(Merchant, :count).by(0)
      end

      it "renders a JSON response with errors for the new merchant" do
        post merchants_url,
             params: { merchant: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { disbursement_frequency: :daily } }

      it "updates the requested merchant" do
        merchant = Merchant.create! valid_attributes
        patch merchant_url(merchant),
              params: { merchant: new_attributes }, headers: valid_headers, as: :json
        merchant.reload
        expect(merchant.disbursement_frequency).to eq("daily")
      end

      it "renders a JSON response with the merchant" do
        merchant = Merchant.create! valid_attributes
        patch merchant_url(merchant),
              params: { merchant: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let(:new_invalid_attributes) { { live_on: nil } }

      it "renders a JSON response with errors for the merchant" do
        merchant = Merchant.create! valid_attributes
        patch merchant_url(merchant),
              params: { merchant: new_invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested merchant" do
      merchant = Merchant.create! valid_attributes
      expect {
        delete merchant_url(merchant), headers: valid_headers, as: :json
      }.to change(Merchant, :count).by(-1)
    end
  end
end
