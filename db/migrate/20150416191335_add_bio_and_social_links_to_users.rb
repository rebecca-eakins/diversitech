class AddBioAndSocialLinksToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :current_zip
    add_column :users, :bio, :text
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :github, :string
  end
end
