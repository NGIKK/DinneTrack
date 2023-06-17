class Tagging < ApplicationRecord
  belongs_to :dinner
  belongs_to :tag
  
end