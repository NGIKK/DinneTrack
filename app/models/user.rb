class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  def self.guest
    find_or_create_by!(name: 'ゲストユーザー' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  has_many :dinners, dependent: :destroy
  has_many :meal_record, dependent: :destroy
  has_one :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 与フォロー関係
  has_many :relationships,foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  # 被フォロー関係
  has_many :reverse_of_relationships,class_name: "Relationship",foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  validates :name, presence: true
  validates :is_deleted, inclusion: { in: [true, false] }


  # アップロード画像を基準点を真ん中にして、cropの引数のサイズに切り取る
  def get_profile_image(resize,crop)
    unless profile_image.attached?
      file_path = Rails.root.join.asset_path('no_image2.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/*')
    end
      profile_image.variant(resize:[resize], gravity: "center", crop: [crop] ).processed
  end

 # 選択ジャンル名の表示用。未選択の場合はテキスト表示。
  def favorite_genre_name(user)
    if user.genre_id.present?
      Genre.find(user.genre_id).name
    else
      "ジャンル未選択"
    end
  end

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

end
