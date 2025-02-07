require "rails_helper"

RSpec.describe ItemAliasesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/item_aliases").to route_to("item_aliases#index")
    end

    it "routes to #show" do
      expect(get: "/item_aliases/1").to route_to("item_aliases#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/item_aliases").to route_to("item_aliases#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/item_aliases/1").to route_to("item_aliases#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/item_aliases/1").to route_to("item_aliases#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/item_aliases/1").to route_to("item_aliases#destroy", id: "1")
    end
  end
end
