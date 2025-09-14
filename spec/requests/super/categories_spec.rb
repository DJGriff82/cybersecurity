require 'rails_helper'

RSpec.describe "Super::Categories", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/super/categories/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/super/categories/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/super/categories/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/super/categories/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
