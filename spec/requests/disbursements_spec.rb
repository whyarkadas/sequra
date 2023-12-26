require 'rails_helper'

RSpec.describe "/disbursements", type: :request do
  let(:merchant) { create(:merchant) }
  let(:valid_attributes) {
    {
      merchant_id:merchant.id,
      creation_date: "2022-01-01",
      amount: 29.0,
      fee: 29.0,
      year: 2022,
      month: 12
    }
  }

  let(:invalid_attributes) {
    {
      creation_date: "2022-01-01",
      amount: 29.0,
      fee: 29.0,
      year: 2022,
      month: 12
    }
  }

  let(:valid_headers) {
    {"Content-Type" => "application/json"}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Disbursement.create! valid_attributes
      get disbursements_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      disbursement = Disbursement.create! valid_attributes
      get disbursement_url(disbursement), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Disbursement" do
        expect {
          post disbursements_url,
               params: { disbursement: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Disbursement, :count).by(1)
      end

      it "renders a JSON response with the new disbursement" do
        post disbursements_url,
             params: { disbursement: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Disbursement" do
        expect {
          post disbursements_url,
               params: { disbursement: invalid_attributes }, as: :json
        }.to change(Disbursement, :count).by(0)
      end

      it "renders a JSON response with errors for the new disbursement" do
        post disbursements_url,
             params: { disbursement: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { amount: 71.74 }
      }

      it "updates the requested disbursement" do
        disbursement = Disbursement.create! valid_attributes
        patch disbursement_url(disbursement),
              params: { disbursement: new_attributes }, headers: valid_headers, as: :json
        disbursement.reload
        expect(disbursement.amount).to eq(71.74)
      end

      it "renders a JSON response with the disbursement" do
        disbursement = Disbursement.create! valid_attributes
        patch disbursement_url(disbursement),
              params: { disbursement: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let(:new_invalid_attributes) { { merchant_id: nil } }

      it "renders a JSON response with errors for the disbursement" do
        disbursement = Disbursement.create! valid_attributes
        patch disbursement_url(disbursement),
              params: { disbursement: new_invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested disbursement" do
      disbursement = Disbursement.create! valid_attributes
      expect {
        delete disbursement_url(disbursement), headers: valid_headers, as: :json
      }.to change(Disbursement, :count).by(-1)
    end
  end
end
