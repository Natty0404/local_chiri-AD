class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render 'edit'
    end
  end

  def favorite
    @favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_list = Post.find(@favorites)
    @favorite_list = Kaminari.paginate_array(@favorite_list).page(params[:page]).per(5)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :is_deleted)
  end


end
