class Service < ApplicationRecord
  has_many :order_details

  enum status: {Public: 1, Pending: 0}

  SERVICE_PARAMS = [:name, :status, :price, :description].freeze

  scope :all_services, ->{select :id, :name, :description, :price}
  scope :other_services, ->(id){where.not id: id}
  scope :by_lastest, -> {order created_at: :desc}
end
