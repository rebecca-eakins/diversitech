class CreatePostLinks < ActiveRecord::Migration
  def change
    create_table :post_links do |t|
      t.integer :parent_post_id
      t.integer :child_post_id

      t.timestamps null: false
    end
  end
end
