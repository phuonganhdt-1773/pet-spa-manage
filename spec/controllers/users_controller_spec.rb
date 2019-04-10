require "rails_helper"

RSpec.describe UsersController, type: :controller do
  before :each do
    user = FactoryBot.create(:user)
    session[:user_id] = user.id
  end

  let!(:valid_user) {
    {
      name: FFaker::Name.name,
      phone: FFaker::PhoneNumberCU.e164_home_work_phone_number,
      address: FFaker::Address.city,
      email: FFaker::Internet.email,
      password: "abc123",
      password_confirmation: "abc123",
      activated: true,
      activation_digest: SecureRandom.urlsafe_base64
    }
  }

  let!(:invalid_user) {
    {
      name: "",
      phone: "",
      address: FFaker::Address.city,
      email: FFaker::Internet.email,
      password: "abc123",
      password_confirmation: "abc123",
      activated: true,
      activation_digest: SecureRandom.urlsafe_base64
    }
  }

  context "#new" do
    it "responds successfully" do
      get :new
      expect(response).to have_http_status(200)
    end

    it "assigns a new user to user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  let!(:user) {FactoryBot.create :user}

  context "#show" do
    it "responds successfully" do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to be_persisted
    end
  end

  context "#create" do
    it "creates user" do
      expect { post :create, params: { user: valid_user} }.to change{User.count}.by(1)
      expect(response).to have_http_status(:redirect)
    end

    it "creates user failed" do
      expect { post :create, params: { user: invalid_user} }.to change{User.count}.by(0)
      expect(response).not_to have_http_status(:redirect)
    end
  end

  context "#edit" do
    before do
      get :edit, params: { id: user.id }
    end
    it "returns http success" do
      expect(response).to have_http_status(302)
    end
    it "assigns the user" do
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "#update" do
    context "#update user successfully" do
      it "creates user" do
        put :update, params: {id: user.id, user: valid_user}
        expect(User.count) == 1
        expect(response).to have_http_status(302)
      end
    end

    context "#update user failed" do
      it "failed params" do
        put :update, params: {id: user.id, user: valid_user}
        expect(User.count) == 0
        expect(flash[:success]).not_to be_present
      end
    end
  end
end
