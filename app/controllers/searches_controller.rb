class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "ユーザー名"
      @users = User.search(params[:word]).page(params[:page]).per(5)
    else
      @posts = Post.search(params[:word]).page(params[:page]).per(5)
    end
  end

end
