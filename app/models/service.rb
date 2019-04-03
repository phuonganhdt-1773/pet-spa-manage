class Service < ApplicationRecord
  has_many :order_details

  enum status: {Public: 1, Pending: 0}

  SERVICE_PARAMS = [:name, :status, :price, :picture, :description].freeze

  validate  :picture_size
  validates :name, presence: true, length: {maximum: Settings.max_service_name}
  validates :price, presence: true, numericality: {only_float: true}
  validates :status, presence: true

  mount_uploader :picture, PictureUploader

  scope :public_service, ->{where status: Settings.status_active}
  scope :get_attr, ->{select :id, :name, :description, :picture, :price}
  scope :all_services, ->{get_attr.public_service.order created_at: :desc}
  scope :other_services, ->(id){public_service.where.not id: id}
  scope :by_lastest, ->{order created_at: :desc}
  scope :most_service, ->(id){where id: id}

  private
  def picture_size
    return unless picture.size > Settings.size_picture.megabytes
    errors.add(:picture, I18n.t(".should_be_less_than_5MB"))
  end
end
