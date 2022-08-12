class Admin::PostsController < ApplicationController

  def new
    @posts = Post.all
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path(@post)
    else
      @posts = Post.all
      render 'index'
    end
  end

  def index
    @posts = Post.page(params[:page]).per(5)
    # @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.page(params[:page]).per(2)
  end

  def edit
  end

  def update
  end

  def destroy
    # @user = User.find(params[:id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_user_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end
end
