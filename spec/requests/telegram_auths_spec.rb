require 'rails_helper'

RSpec.describe "TelegramAuths", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/telegram_auths/create"
      expect(response).to have_http_status(:success)
    end
  end

end
