require "rails_helper"

RSpec.describe Admin::PostsController, type: :controller do
  before :each do
    user = FactoryBot.create(:user)
    session[:user_id] = user.id
  end

  let(:valid_post) {
    {
      title: FFaker::Lorem.phrase,
      content: FFaker::Lorem.paragraphs,
      sumary: FFaker::Lorem.phrase,
      picture: FFaker::Image.url,
      status: "Pending"
    }
  }

  let(:invalid_post_params) {
    {
      title: FFaker::Lorem.phrase,
      content: "",
      sumary: "",
      picture: "",
      status: "Pending"
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
    it "assigns a new post to @post" do
      get :new
      expect(assigns(:postz)).to be_a_new(Post)
    end
  end

  describe "#create" do
    context "#create successfully" do
      it "creates post" do
        expect{post :create, params: {postz: valid_post}}
        expect(Post.count) == 1
        expect(response).to have_http_status(200)
      end
    end

    context "#create post failed" do
      it "create failed params" do
        post :create, params: {postz: invalid_post_params}
        expect(Post.count) == 0
        expect(flash[:error]).to be_present
      end
    end
  end

  let!(:postz) {FactoryBot.create :post}

  context "#delete" do
    it "delete the post" do
      expect {delete :destroy, params: { id: postz.id }}.to change(Post, :count).by(-1)
      expect(flash[:success]).to be_present
    end

    it "delete post failed" do
      expect {delete :destroy, params: { id: "" }}.to change(Post, :count).by(0)
      expect(flash[:success]).not_to be_present
    end
  end

  describe "#update" do
    context "#update successfully" do
      it "creates post" do
        put :update, params: {id: postz.id, postz: valid_post}
        expect(Post.count).to eq(1)
        expect(response).to have_http_status(302)
        expect(flash[:success]).to be_present
      end
    end

    context "#update post failed" do
      it "failed params" do
        expect{put :update, params: {id: postz.id, postz: invalid_post_params}}.to change(Post, :count).by(0)
        expect(response).to have_http_status(200)
        expect(flash[:success]).not_to be_present
      end
    end
  end
end

