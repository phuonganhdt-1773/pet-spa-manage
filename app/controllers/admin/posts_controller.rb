class Admin::PostsController < Admin::BaseController
  before_action :verify_admin!, only: %i(create index destroy)
  before_action :load_post, :logged_in_user, only: %i(edit update destroy)

  def index
    @posts = Post.search(params[:term]).page(params[:page]).per Settings.quantity_per_page
  end

  def new
    @postz = Post.new
  end

  def create
    @postz = Post.new post_params
    if @postz.save
      flash[:success] = t(".created")
      redirect_to admin_posts_path
    else
      flash[:error] = t(".create_unsuccess")
      render :new
    end
  end

  def edit; end

  def update
    if @post.update post_params
      flash[:success] = t(".post_updated")
      redirect_to admin_posts_path
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t(".post_deleted")
      redirect_to admin_posts_path
    else
      flash[:error] = t(".delete_failed")
      redirect_to admin_posts_path
    end
  end

  private

  def post_params
    params.require(:postz).permit Post::POST_PARAMS
  end

  def load_post
    @post = Post.find_by id: params[:id]
    return if @post
    flash[:error] = t(".post_not_found")
    redirect_to admin_posts_path
  end
end
