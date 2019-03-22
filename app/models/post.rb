class Post < ApplicationRecord
  has_many :like
  has_many :comment
end
