class UsersController < ApplicationController
  before_action :load_user, only: %i(show)

  def index
    @users = User.page(params[:page]).per Settings.quantity_per_page
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t(".welcome_to_pet_spa_house")
      redirect_to @user
    else
      render :new
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

  def destroy
    log_out
    redirect_to root_url
  end
end
