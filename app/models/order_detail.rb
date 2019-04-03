class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :pet
  belongs_to :service

  delegate :date, to: :order, prefix: true
  delegate :name, to: :pet, prefix: true
  delegate :name, to: :service, prefix: true
  delegate :price, to: :service, prefix: true

  scope :count_max, ->{select(:service_id).group(:service_id).count}
  scope :detail, ->(order_id){where order_id: order_id}

  def self.revenue year
    OrderDetail.find_by_sql("
      SELECT MONTH(created_at) AS 'month', SUM(price) AS 'revenue'
      FROM order_details WHERE YEAR(created_at) = '#{year}'
      GROUP BY MONTH(created_at)
      ")
  end
end
