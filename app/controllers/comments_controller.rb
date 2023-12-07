class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[ show edit update destroy ]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      render 'posts/show'
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
      redirect_to @comment.post, notice: "Comment was successfully updated."
  end

  def destroy
    @comment.destroy!
      redirect_to comments_url, notice: "Comment was successfully destroyed."
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      permitted_params = params.require(:comment).permit(:content, :user_id, :post_id)
      permitted_params[:status] = params[:status] if current_user.admin? || current_user.moderator?
      permitted_params
    end
end
