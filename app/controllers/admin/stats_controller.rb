class Admin::StatsController < Admin::BaseController
  def index
    @values_max = OrderDetail.count_max.values.max
    @id_service = OrderDetail.count_max.key(@values_max)
    @service = Service.most_service(@id_service)

    @revenue = {};
    OrderDetail.revenue(Settings.year_stats).each {|i| @revenue[i.month] = i.revenue}
  end
end
