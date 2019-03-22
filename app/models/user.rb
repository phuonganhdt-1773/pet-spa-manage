class User < ApplicationRecord
  has_many :pet
  has_many :order
  has_many :like
  has_many :comment
end
