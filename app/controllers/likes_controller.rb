class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.find_or_initialize_by(user_id: current_user.id, post_id: params[:post_id])
    if @like.persisted?
      @like.destroy
    else
      @like.save
    end
    redirect_to request.referrer || root_path
  end

  private
    def set_like
      @like = Like.find(params[:id])
    end

    def like_params
      params.require(:like).permit(:user_id, :post_id)
    end
end
