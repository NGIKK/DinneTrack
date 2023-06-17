class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :dinners, through: :taggings

  # 空白登録NG
  validates :name, presence: true
  # 重複登録NG
  validates :name, uniqueness: true

end