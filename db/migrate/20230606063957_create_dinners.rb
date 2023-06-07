class CreateDinners < ActiveRecord::Migration[6.1]
  def change
    create_table :dinners do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :genre_id, foreign_key: true, null: false
      t.string :title, null: false
      t.integer :cost, null: false
      t.text :memo
      t.integer :style, null: false
      t.boolean :is_posted, null: false
      t.timestamps
    end
  end
end
