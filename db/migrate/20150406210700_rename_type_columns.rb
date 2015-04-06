class RenameTypeColumns < ActiveRecord::Migration
  def change
    rename_column :resources, :type, :resource_type
    rename_column :user_institutions, :type, :institution_type
  end
end
