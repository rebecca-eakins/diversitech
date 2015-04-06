class CreateResourceTopics < ActiveRecord::Migration
  def change
    create_table :resource_topics do |t|
      t.references :resource, index: true
      t.references :topic, index: true

      t.timestamps null: false
    end
    add_foreign_key :resource_topics, :resources
    add_foreign_key :resource_topics, :topics
  end
end
