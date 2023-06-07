class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :dinner_id, foreign_key: true, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
