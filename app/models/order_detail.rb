class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :pet
  belongs_to :service

  delegate :date, to: :order, prefix: true
  delegate :name, to: :pet, prefix: true
  delegate :name, to: :service, prefix: true

  private
  def update_price
    service = Service.find_by id: self.service_id
    return unless service
    self.update price: service.price
  end
end
