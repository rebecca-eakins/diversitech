class UserInstitutionsController < ApplicationController
  def create
    binding.pry
    @ui = UserInstitution.find_or_create_by(ui_params)
    redirect_to :back
  end

  def destroy
    UserInstitution.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def ui_params
    params.require(:user_institution).permit(:user_id, :institution_id, :institution_type, :start_date, :end_date)
  end

end