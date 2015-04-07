class AddGoalIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :goal_id, :integer
    add_index :posts, :goal_id
  end
end
