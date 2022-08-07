class Users::SessionsController < Devise::SessionsController
  before_action :reject_inactive_user, only: [:create]

  def reject_inactive_user
    @user = User.find_by(name: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_user_session_path
      end
    end
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: 'ゲストユーザーとしてログインしました。'
  end
end