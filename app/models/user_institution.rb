class UserInstitution < ActiveRecord::Base
  belongs_to :user
  belongs_to :institution
end
