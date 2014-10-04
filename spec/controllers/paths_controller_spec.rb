require 'rails_helper'

RSpec.describe PathsController, :type => :controller do

  describe "GET first" do
    it "returns http success" do
      get :random
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET shortest" do
    it "returns http success" do
      get :shortest
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET approximate_time" do
    it "returns http success" do
      get :approximate_time
      expect(response).to have_http_status(:success)
    end
  end

end
