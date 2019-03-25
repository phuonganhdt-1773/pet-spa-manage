class User < ApplicationRecord
  has_many :pets
  has_many :orders
  has_many :likes
  has_many :comments

  before_save {email.downcase!}

  USER_PARAMS = [:name, :email, :password, :password_confirmation].freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  enum type_user: {admin: 0, user: 1}

  validates :name, presence: true, length: { maximum: Settings.max_name_lenght }
  validates :email, presence: true,
      length: { maximum: Settings.max_email_lenght },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true,
      length: { minimum: Settings.min_pass_lenght }

  has_secure_password
end
