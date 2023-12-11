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
    @comment.status = current_user&.role == "user" ? true : @comment.status

    if @comment.save
      create_notification(@post.user, @comment)
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      render 'posts/show'
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.status = current_user&.role == "user" ? true : @comment.status
    @comment.update(comment_params)
      redirect_to @comment.post, notice: "Comment was successfully updated."
  end

  def destroy
    post = @comment.post
    @comment.destroy!
    redirect_to post, notice: "Comment was successfully destroyed."
  end

  private
    def create_notification(recipient, comment)
      Notification.create(user: recipient, body: "#{comment.user.username} commented on your post: #{comment.post.title}")
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id, :status)
    end
end
