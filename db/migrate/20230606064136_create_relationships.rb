class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      # foregin_key :trueとすると存在しないテーブルを参照してしまうため、usersテーブルと紐付け
      t.references :follower, foreign_key: {to_table: :users}
      t.references :followed, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
