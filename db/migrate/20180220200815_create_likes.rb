class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :tweet_id
      t.integer :user_id
    end
  end
end
