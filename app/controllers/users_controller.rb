class UsersController < ApplicationController
  before_action :correct_user, only: %i(edit update)
  before_action :verify_admin!, only: %i(destroy)
  before_action :load_user, :logged_in_user, except: %i(new create)

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t(".please_check_your_email_to_activate_your_account")
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t(".profile_updated")
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = t(".user_not_found")
    redirect_to root_path
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless current_user?(@user)
  end
end
