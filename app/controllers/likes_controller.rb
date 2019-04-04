class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: :destroy

  def create
    if liked?
      flash[:error] = t ".cannot_like"
      redirect_to post_path @post
    else
      @post.likes.create user_id: current_user.id
      user_like
      respond_to do |format|
        format.html {redirect_to post_path @post}
        format.js
      end
    end
  end

  def destroy
    if !(liked?) && @post.likes.find{|like| like.user_id == current_user.id}
      flash[:error] = t ".cannot_dislike"
      redirect_to post_path @post
    else
      @like.destroy
      user_like
      respond_to do |format|
        format.html {redirect_to post_path @post}
        format.js
      end
    end
  end

  private
  def find_post
    @post = Post.find_by id: params[:post_id]
  end
  def liked?
    Like.find_by user_id: current_user, post_id: params[:post_id]
  end
  def find_like
    @like = @post.likes.find_by id: params[:id]
    return if @like
    flash[:error] = t ".like_not_found"
  end
  def user_like
    @pre_like = @post.likes.find{|like| like.user_id == current_user.id}
  end
end
