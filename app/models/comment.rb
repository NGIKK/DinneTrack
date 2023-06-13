class Comment < ApplicationRecord
 belongs_to :user
 belongs_to :dinner

 validates :body, presence: true
end
