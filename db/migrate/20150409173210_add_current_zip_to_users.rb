class AddCurrentZipToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_zip, :integer
  end
end
