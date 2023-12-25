require "rails_helper"

RSpec.describe ScheduledTasksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/scheduled_tasks").to route_to("scheduled_tasks#index")
    end

    it "routes to #show" do
      expect(get: "/scheduled_tasks/1").to route_to("scheduled_tasks#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/scheduled_tasks").to route_to("scheduled_tasks#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/scheduled_tasks/1").to route_to("scheduled_tasks#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/scheduled_tasks/1").to route_to("scheduled_tasks#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/scheduled_tasks/1").to route_to("scheduled_tasks#destroy", id: "1")
    end
  end
end
