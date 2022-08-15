class Users::SessionsController < Devise::SessionsController
  before_action :reject_inactive_user, only: [:create]

  def reject_inactive_user
    @user = User.find_by(name: params[:user][:name])
    if @user
      if @user.valid_password?(params[:user][:password]) &&  (@user.active_for_authentication? == false)
      redirect_to new_user_session_path
      end
    end
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user)
  end
end