class CreateUserInstitutions < ActiveRecord::Migration
  def change
    create_table :user_institutions do |t|
      t.string :type
      t.references :user, index: true
      t.references :institution, index: true
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
    add_foreign_key :user_institutions, :users
    add_foreign_key :user_institutions, :institutions
  end
end
