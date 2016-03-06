class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build(post_params)
      if @post.save
        flash[:success] = "Post created"
        redirect_to posts_path
      else
        flash[:alert] = "Post not created, check details"
        render :new
      end
  end

  def create
    @post = Post.create(post_params)
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

end
