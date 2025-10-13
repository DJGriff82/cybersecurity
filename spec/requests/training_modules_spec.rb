require 'rails_helper'

RSpec.describe "TrainingModules", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/training_modules/show"
      expect(response).to have_http_status(:success)
    end
  end

end
