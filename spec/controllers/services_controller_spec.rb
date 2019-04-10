require "rails_helper"

RSpec.describe ServicesController, type: :controller do
  context "#index" do
    it "responds successfully" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  context "#show" do
    it "responds successfully" do
      service = FactoryBot.create(:service)
      get :show, params: { id: service.id }
      expect(assigns(:service)).to be_persisted
    end
  end
end
