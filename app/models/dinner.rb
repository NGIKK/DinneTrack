class Dinner < ApplicationRecord
  has_one_attached :dinner_image
  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  enum style: {eating_out: 0, taking_in:1, home_cooking: 2}

  validates :title, :cost, :memo, presence: true
  validates :style, inclusion: { in: Dinner.styles.keys }
  validates :is_posted, inclusion: { in: [true, false] }

end
