class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, only: %i(edit update)

  def new; end

  def create
    if @user = User.find_by(email: params[:password_reset][:email].downcase)
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t(".email_sent_with_password_reset_instructions")
      redirect_to root_url
    else
      flash.now[:danger] = t(".email_address_not_found")
      render :new
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t(".not_empty"))
      render :edit
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = t(".reset_succeed")
      redirect_to @user
    else
      render :edit
    end
  end

  def edit; end

  private

  def user_params
    params.require(:user).permit User::PASSWORD_PARAMS
  end

  def get_user
    @user = User.find_by email: params[:email]
    return if @user
    flash[:error] = t(".user_not_found")
    redirect_to root_path
  end

  def valid_user
    return if (@user&.activated?)
    flash[:error] = ".user_not_active"
    redirect_to root_url
  end
end
