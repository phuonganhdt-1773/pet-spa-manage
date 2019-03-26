class Admin::CommentsController < Admin::BaseController
  def index
    @comments = Comment.page(params[:page]).includes(:user, :post).per Settings.per_page
  end
end
