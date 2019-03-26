class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  delegate :title, to: :post, prefix: true
  delegate :name, to: :user, prefix: true
end
