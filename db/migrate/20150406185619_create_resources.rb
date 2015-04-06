class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :description
      t.string :title
      t.string :type
      t.timestamps null: false
    end
  end
end
