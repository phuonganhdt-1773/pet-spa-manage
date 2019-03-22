class Pet < ApplicationRecord
  belongs_to :user
  has_many :order_detail
end
