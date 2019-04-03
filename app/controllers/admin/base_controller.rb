class Admin::BaseController < ApplicationController
  before_action :logged_in_user, :verify_admin!
  layout "admin/index"

  def home; end
end
