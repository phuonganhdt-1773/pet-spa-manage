class Admin::BaseController < ApplicationController
  before_action :verify_admin!
  layout "admin/index"

  def home; end
end
