class UserInstitutionsController < ApplicationController
  def create
    @ui = UserInstitution.find_or_create_by(ui_params)
  end

  private

  def ui_params
    params.require(:user_institution).permit(:user_id, :institution_id, :institution_type, :start_date, :end_date)
  end

end