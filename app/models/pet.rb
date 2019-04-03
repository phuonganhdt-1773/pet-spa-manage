class Pet < ApplicationRecord
  has_many :order_details, dependent: :destroy

  PET_PARAMS = [:name, :description, :term].freeze

  validates :name, presence: true, length: {maximum: Settings.max_name_lenght}
  validates :description, presence: true,
    length: {maximum: Settings.max_sumary_length}

  scope :by_lastest, -> {order created_at: :desc}
  scope :all_pets, ->{select :id, :name}

  def self.search term
      if term
        where("name LIKE ? OR description LIKE ?", "%#{term}%", "%#{term}%")
      else
        all
      end
    end
end
