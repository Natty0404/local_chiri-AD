class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!

  # フォロー 一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  # フォロワー 一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

end
