class UserInstitution < ActiveRecord::Base
  belongs_to :user
  belongs_to :institution

  validates :institution_type, inclusion: { in: %w(school work),
    message: "%{value} is not a valid user_institution type. Please select 'school' or 'work'." }, allow_blank: true
end
