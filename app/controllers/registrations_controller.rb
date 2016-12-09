class RegistrationsController < Devise::RegistrationsController
	def sign_up_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end
end
