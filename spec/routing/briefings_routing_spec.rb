require "spec_helper"

describe BriefingsController do
  describe "routing" do

    it "routes to #index" do
      get("/briefings").should route_to("briefings#index")
    end

    it "routes to #new" do
      get("/briefings/new").should route_to("briefings#new")
    end

    it "routes to #show" do
      get("/briefings/1").should route_to("briefings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/briefings/1/edit").should route_to("briefings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/briefings").should route_to("briefings#create")
    end

    it "routes to #update" do
      put("/briefings/1").should route_to("briefings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/briefings/1").should route_to("briefings#destroy", :id => "1")
    end

  end
end
