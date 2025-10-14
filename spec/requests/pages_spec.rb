require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /phishing" do
    it "returns http success" do
      get "/pages/phishing"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /social_engineering" do
    it "returns http success" do
      get "/pages/social_engineering"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /password_security" do
    it "returns http success" do
      get "/pages/password_security"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /malware_awareness" do
    it "returns http success" do
      get "/pages/malware_awareness"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get "/pages/contact"
      expect(response).to have_http_status(:success)
    end
  end

end
