require 'rails_helper'

RSpec.describe "Admin::UserProgresses", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/user_progress/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/user_progress/show"
      expect(response).to have_http_status(:success)
    end
  end

end
