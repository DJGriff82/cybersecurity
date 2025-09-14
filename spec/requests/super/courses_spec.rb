require 'rails_helper'

RSpec.describe "Super::Courses", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/super/courses/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/super/courses/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/super/courses/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/super/courses/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
