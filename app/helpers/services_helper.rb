module ServicesHelper
  def all_services
    Service.all_services
  end

  def show_status
    [t(".public"), t(".pending")]
  end
end
