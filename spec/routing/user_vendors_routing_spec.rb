require "rails_helper"

RSpec.describe UserVendorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user_vendors").to route_to("user_vendors#index")
    end

    it "routes to #show" do
      expect(get: "/user_vendors/1").to route_to("user_vendors#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user_vendors").to route_to("user_vendors#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user_vendors/1").to route_to("user_vendors#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user_vendors/1").to route_to("user_vendors#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user_vendors/1").to route_to("user_vendors#destroy", id: "1")
    end
  end
end
