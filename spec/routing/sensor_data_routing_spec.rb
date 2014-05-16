require "spec_helper"

describe SensorDataController do
  describe "routing" do

    it "routes to #index" do
      get("/sensor_data").should route_to("sensor_data#index")
    end

    it "routes to #new" do
      get("/sensor_data/new").should route_to("sensor_data#new")
    end

    it "routes to #show" do
      get("/sensor_data/1").should route_to("sensor_data#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sensor_data/1/edit").should route_to("sensor_data#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sensor_data").should route_to("sensor_data#create")
    end

    it "routes to #update" do
      put("/sensor_data/1").should route_to("sensor_data#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sensor_data/1").should route_to("sensor_data#destroy", :id => "1")
    end

  end
end
