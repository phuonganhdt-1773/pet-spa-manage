require "rails_helper"

RSpec.describe Admin::ServicesController, type: :controller do
  before :each do
    user = FactoryBot.create(:user)
    session[:user_id] = user.id
  end

  let(:valid_service) {
    {
      name: FFaker::Name.name,
      description: FFaker::Lorem.phrase,
      price: 12.2,
      status: "Public",
      picture: FFaker::Image.url
    }
  }

  let(:invalid_service) {
    {
      name: "",
      description: FFaker::Lorem.phrase,
      price: 12.2,
      status: "Public",
      picture: FFaker::Image.url
    }
  }

  context "#index" do
    it "responds successfully" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  context "#new" do
    it "responds successfully" do
      get :new
      expect(response).to have_http_status(200)
    end

    it "assigns a new service to service" do
      get :new
      expect(assigns(:service)).to be_a_new(Service)
    end
  end

  context "#create" do
    it "creates service successfully" do
      expect { post :create, params: { service: valid_service} }.to change(Service, :count).by(1)
      expect(flash[:success]).to be_present
    end

    it "creates service failed" do
      expect { post :create, params: { service: invalid_service} }.to change(Service, :count).by(0)
      expect(flash[:success]).not_to be_present
    end
  end

  let!(:service) {FactoryBot.create :service}
  context "#delete" do
    it "delete the service" do
      expect {delete :destroy, params: { id: service.id }}.to change(Service, :count).by(-1)
      expect(flash[:success]).to be_present
    end

    it "delete the service failed" do
      expect {delete :destroy, params: { id: ""}}.to change(Service, :count).by(0)
      expect(flash[:success]).not_to be_present
    end
  end

  describe "#update" do
    context "#update service successfully" do
      it "creates service" do
        post :update, params: {id: service.id, service: valid_service}
        expect(Post.count) == 1
        expect(response).to have_http_status(302)
      end
    end

    context "#update service failed" do
      it "failed params" do
        post :update, params: {id: service.id, service: invalid_service}
        expect(Post.count) == 0
        expect(flash[:success]).not_to be_present
      end
    end
  end
end
