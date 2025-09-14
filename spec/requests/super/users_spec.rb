require 'rails_helper'

RSpec.describe "Super::Users", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/super/users/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/super/users/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/super/users/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/super/users/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
