class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.belongs_to :follower, index: true
      t.belongs_to :target, index: true
      t.string :connection_status
      t.boolean :reach_out, null: false, default: FALSE

      t.timestamps null: false
    end
  end
end
