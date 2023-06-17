class CreateTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :taggings do |t|
      t.integer :dinner_id, foreign_key: true, null: false
      t.integer :tag_id, foreign_key: true, null: false
      t.timestamps
    end
     # 同じタグの重複登録をできないようにする
    add_index :taggings, [:dinner_id, :tag_id], unique: true

  end
end
