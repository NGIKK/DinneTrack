class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :dinner_id, foreign_key: true, null: false
      t.timestamps
    end
  end
end
