require 'rails_helper'

RSpec.describe "SearchTmdbs", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/search_tmdb/index"
      expect(response).to have_http_status(:success)
    end
  end

end
