class Admin::UsersController < Admin::BaseController
  def index
    @users = User.search(params[:term]).page(params[:page]).per Settings.quantity_per_page
  end

  def destroy
    @user = User.find_by id: params[:id]
    if @user.destroy
      flash[:success] = t(".user_delete_succeed")
    else
      flash[:error] = t(".user_delete_failed")
    end
    redirect_to admin_users_url
  end
end
