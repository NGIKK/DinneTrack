class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image

  has_many :dinners, dependent: :destroy
  has_many :meal_record, dependent: :destroy
  has_one :genre_id
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 与フォロー関係
  has_many :relationships,foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  # 被フォロー関係
  has_many :reverse_op_relationships,class_name:"Relationship",foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :relationships, source: :follower
  
  validates :name, presence: true
  validates :is_deleted, inclusion: { in: [true, false] }
            
  
end
