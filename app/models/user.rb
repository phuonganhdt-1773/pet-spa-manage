class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :pets
  has_many :orders
  has_many :likes
  has_many :comments

  before_save {email.downcase!}

  USER_PARAMS = [:name, :email, :password, :password_confirmation].freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  enum type_user: {admin: 0, user: 1}

  validates :name, presence: true, length: {maximum: Settings.max_name_lenght}
  validates :email, presence: true, length: {maximum: Settings.max_email_lenght},
   format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.min_pass_lenght}

  has_secure_password

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update remember_digest: nil
  end
end
