class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, notice: 'User deleted'
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update_attributes(secure_params)
      redirect_to users_path, :success => "User updated"
    else
      redirect_to users_path, :alert => 'Unabe to update usr'
    end
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end
end
