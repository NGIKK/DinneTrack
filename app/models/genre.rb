class Genre < ApplicationRecord
  has_many :dinners, dependent: :destroy
  has_many :set_null_user, dependent: :nullify
  
  validates :name,presence: true
end
