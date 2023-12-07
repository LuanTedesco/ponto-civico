class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

      @post.save
        redirect_to post_url(@post), notice: "Post was successfully created."
  end

  def update
      @post.update(post_params)
        redirect_to post_url(@post), notice: "Post was successfully updated."
  end

  def destroy
    @post.destroy!
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      permitted_params = params.require(:post).permit(:title, :body, :user_id)
      permitted_params[:status] = params[:status] if current_user.admin? || current_user.moderator?
      permitted_params
    end
end
