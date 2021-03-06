class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created"
      redirect_to posts_path
    else
      flash[:alert] = "Pic needed to create post"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to(post_path(@post))
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = 'Post successfully deleted'
    redirect_to posts_path
  end

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  private
    def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post is not yours to delete"
      redirect_to root_path
    end
  end

end
