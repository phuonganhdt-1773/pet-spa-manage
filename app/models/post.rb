class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum status: {Public: 1, Pending: 0}

  POST_PARAMS = [:title, :content, :sumary, :picture].freeze

  scope :acive_post, ->{where status: Settings.status_active}
  scope :get_attr, ->{select :id, :title, :sumary, :picture, :content}
  scope :most_likes, ->{where(like_quantity: self.maximum(:like_quantity)).acive_post}
  scope :other_posts, ->(id){acive_post.where.not id: id}
  scope :all_posts, ->{acive_post.get_attr.order created_at: :desc}
  scope :by_lastest, ->{order created_at: :desc}

  POST_PARAMS = [:title, :content, :sumary, :picture, :status, :term].freeze

  validate  :picture_size
  validates :title, presence: true, length: {maximum: Settings.max_title_length}
  validates :content, presence: true,
    length: {minimum: Settings.min_content_length}
  validates :sumary, presence: true,
    length: {maximum: Settings.max_sumary_length}

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    if picture.size > Settings.size_picture.megabytes
      errors.add(:picture, I18n.t(".should_be_less_than_5MB"))
    end
  end

  def self.search term
    if term
      where("title LIKE ?", "%#{term}%")
    else
      all
    end
  end
end
