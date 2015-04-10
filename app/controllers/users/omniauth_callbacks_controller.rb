class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    @new_user = !User.github_user_exist?(request.env["omniauth.auth"])
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      # sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      if @new_user
        sign_in @user, :event => :authentication
        flash[:new_user] = "Please tell us some more about yourself."
        redirect_to edit_user_path(@user, new_user: @new_user)
      else
        sign_in_and_redirect @user, :event => :authentication
      end
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end