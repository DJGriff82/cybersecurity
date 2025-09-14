require 'rails_helper'

RSpec.describe "Super::Companies", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/super/companies/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/super/companies/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/super/companies/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/super/companies/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
