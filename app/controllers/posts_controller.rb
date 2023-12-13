class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.where(status: true)
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
    @post.status = current_user&.role == "user" ? true : @post.status

    @post.save
      redirect_to post_url(@post), notice: "Post was successfully created."
  end

  def update
      @post.status = current_user&.role == "user" ? true : @post.status
      @post.update(post_params)
        redirect_to post_url(@post), notice: "Post was successfully updated."
  end

  def destroy
    @post.destroy!
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  def search
    @search_term = params[:search_term]
    @posts = Post.where("title LIKE ?", "%#{@search_term}%")

    render :index
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :image, :user_id, :status, :category_id)
    end
end