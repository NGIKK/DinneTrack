class DinnerForm
  # ActiveRecordと同じような働きを持たせる
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attr_accessor :user_id, :genre_id, :title, :cost, :memo, :style, :is_posted, :name, :dinner_id, :tag_id
  
  def save
    
  end
end