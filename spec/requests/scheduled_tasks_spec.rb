require 'rails_helper'

RSpec.describe "/scheduled_tasks", type: :request do
  let(:merchant) { create(:merchant) }
  let(:valid_attributes) {
    {
      merchant_id:merchant.id,
      scheduled_at: DateTime.now + 1.day,
    }
  }

  let(:invalid_attributes) {
    {
      scheduled_at: "2022-01-01 08:00",
    }
  }

  let(:valid_headers) {
    {"Content-Type" => "application/json"}
  }

  describe "GET /index" do
    it "renders a successful response" do
      ScheduledTask.create! valid_attributes
      get scheduled_tasks_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      scheduled_task = ScheduledTask.create! valid_attributes
      get scheduled_task_url(scheduled_task), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ScheduledTask" do
        expect {
          post scheduled_tasks_url,
               params: { scheduled_task: valid_attributes }, headers: valid_headers, as: :json
        }.to change(ScheduledTask, :count).by(2) ## Becase merchant has after create callback to create ScheduledTask also.
      end

      it "renders a JSON response with the new scheduled_task" do
        post scheduled_tasks_url,
             params: { scheduled_task: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ScheduledTask" do
        expect {
          post scheduled_tasks_url,
               params: { scheduled_task: invalid_attributes }, as: :json
        }.to change(ScheduledTask, :count).by(0)
      end

      it "renders a JSON response with errors for the new scheduled_task" do
        post scheduled_tasks_url,
             params: { scheduled_task: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { scheduled_at: "2025-01-01 09:00" }
      }

      it "updates the requested scheduled_task" do
        scheduled_task = ScheduledTask.create! valid_attributes
        patch scheduled_task_url(scheduled_task),
              params: { scheduled_task: new_attributes }, headers: valid_headers, as: :json
        scheduled_task.reload
        expect(scheduled_task.scheduled_at.to_s).to eq("2025-01-01 09:00:00 UTC")
      end

      it "renders a JSON response with the scheduled_task" do
        scheduled_task = ScheduledTask.create! valid_attributes
        patch scheduled_task_url(scheduled_task),
              params: { scheduled_task: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let(:new_invalid_attributes) { { merchant_id: nil } }

      it "renders a JSON response with errors for the scheduled_task" do
        scheduled_task = ScheduledTask.create! valid_attributes
        patch scheduled_task_url(scheduled_task),
              params: { scheduled_task: new_invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested scheduled_task" do
      scheduled_task = ScheduledTask.create! valid_attributes
      expect {
        delete scheduled_task_url(scheduled_task), headers: valid_headers, as: :json
      }.to change(ScheduledTask, :count).by(-1)
    end
  end
end
