class CreateMealRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :meal_records do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.string :breakfast_memo
      t.integer :breakfast_cost, null:false, default: 0
      t.string :lunch_memo
      t.integer :lunch_cost, null:false, default: 0
      t.string :dinner_memo
      t.integer :dinner_cost, null:false, default: 0
      t.string :snack_memo
      t.integer :snack_cost, null:false, default: 0
      t.string :something_memo
      t.integer :something_cost, null:false, default: 0
      t.datetime :track_date,null: false
      t.timestamps
    end
  end
end
