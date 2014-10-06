require 'rails_helper'

RSpec.describe PathsController, :type => :controller do
  after(:all) do
    Neo4j.shutdown
    `rm -rf db/neo4j-test/`
  end

  before(:all) do
    Station.create_stations
    Station.create_routes
    Line.create_lines
  end

  describe "GET shortest" do
    it "returns bad request when the parameters aren't specified" do
      get :shortest
      expect(response).to have_http_status(:bad_request)
    end

    it "returns bad request when one of the stations aren't found" do
      get :shortest, { station_1: '11', station_2: '9999' }
      expect(response).to have_http_status(:bad_request)
    end

    it 'discovers successfully the shortest path' do
      get :shortest, { station_1: '11', station_2: '290' }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({"shortest"=>["Baker Street", "Finchley Road", "West Hampstead"]})
    end
  end

  describe "GET approximate_time" do
    it "returns bad request when the parameters aren't specified" do
      get :approximate_time
      expect(response).to have_http_status(:bad_request)
    end

    it "returns bad request when one of the stations aren't found" do
      get :approximate_time, { station_1: '11', station_2: '9999' }
      expect(response).to have_http_status(:bad_request)
    end

    it 'discovers successfully the shortest path' do
      get :approximate_time, { station_1: '11', station_2: '290' }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({"approximate_time_in_minutes"=>"15"})
    end
  end
end
