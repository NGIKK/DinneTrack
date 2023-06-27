class Dinner < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_one_attached :dinner_image

  enum style: {eating_out: 0, taking_in:1, home_cooking: 2}

  validates :title, :cost, presence: true
  validates :style, inclusion: { in: Dinner.styles.keys }
  validates :is_posted, inclusion: { in: [true, false] }


  # 関連テーブルへの一括データ保存
  accepts_nested_attributes_for :taggings, allow_destroy: true
  accepts_nested_attributes_for :tags

  # タグ登録時の処理
  def tags_attributes=(tag_attributes)
    # 送られてきたタグパラメータの重複排除後、タグ追加の処理を行う
    tag_attributes.values.uniq.each do |tag_params|
      if tag_params["name"].present?
        # DBに重複がない場合は作成、重複している場合は既に登録されているデータを使用
        tag = Tag.find_or_create_by(tag_params)
        # 同じタグが紐づいていない場合、投稿とタグを紐付け。(複合ユニークキー制約)
        self.tags << tag if self.tags.where(name: tag["name"]).blank?
      end
    end
  end

 # ジャンル別に投稿した夕食を取り出す
  scope :post_dinner_genre, ->(n) {where(genre_id: n)}

 # スタイル別に投稿した夕食を取り出す
  scope :post_dinner_style, ->(n) {where(style: n)}

   def get_dinner_image(resize,crop)
    unless dinner_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image2.jpeg')
      dinner_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      dinner_image.variant(resize:[resize], gravity: "center", crop: [crop] ).processed
   end

    def dinner_is_posted
     if self.is_posted == true
       "登録中"
     else
      "未登録"
     end
    end

   def favorited_by?(user)
     favorites.exists?(user_id: user.id)
   end

   # ジャンル別 投稿夕食数
   def self.post_dinner_genre_count
        (1..5).map { |n| post_dinner_genre(n).count }
   end

   # スタイル別 投稿夕食数
   def self.post_dinner_style_count
        (0..3).map { |n| post_dinner_style(n).count }
   end

   def self.ransackable_attributes(auth_object = nil)
    ["title"]
   end
  
  
end
