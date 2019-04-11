require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  before :each do
    user = FactoryBot.create(:user)
    session[:user_id] = user.id
  end

  context "#index" do
    it "responds successfully" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  let!(:a_user) {FactoryBot.create :user}

  context "#delete" do
    it "delete the user" do
      expect {delete :destroy, params: {id: a_user.id }}.to change(User, :count).by(-1)
      expect(flash[:success]).to be_present
    end

    it "delete the user failed" do
      expect(flash[:success]).not_to be_present
    end
  end
end
