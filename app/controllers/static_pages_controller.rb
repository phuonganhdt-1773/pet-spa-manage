class StaticPagesController < ApplicationController
  def home
    @post = Post.most_likes.limit Settings.limit_post_home
    @services = Service.all_services.limit Settings.limit_home
    @posts = Post.all_posts.limit Settings.limit_home
  end

  def about_us; end

  def contact; end
end
