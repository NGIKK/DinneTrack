class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :dinners, through: :taggings
end