require "rails_helper"

RSpec.describe PostsController, type: :controller do
  before :each do
    user = FactoryBot.create(:user)
    session[:user_id] = user.id

    post = FactoryBot.create :post
    other_posts = FactoryBot.create :post
    comments = post.comments.includes(:user).order(created_at: :desc)
    comment = FactoryBot.create :comment
    pre_like = post.likes.find{|like| like.user_id == current_user.id}
  end

  context "#index" do
    it "responds successfully" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  context "#show" do
    it "responds successfully" do
      post = FactoryBot.create(:post)
      get :show, params: { id: post.id }
      expect(assigns(:post)).to be_persisted
    end
  end
end
