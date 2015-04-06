class CreatePostTopics < ActiveRecord::Migration
  def change
    create_table :post_topics do |t|
      t.references :post, index: true
      t.references :topic, index: true

      t.timestamps null: false
    end
    add_foreign_key :post_topics, :posts
    add_foreign_key :post_topics, :topics
  end
end
