class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authorize_user

  def index
    @categories = Category.where(status: true)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    @category.status = current_user&.role == "user" ? true : @category.status
    @category.save
      redirect_to categories_path, notice: "Category was successfully created."
  end

  def update
    @category.update(category_params)
    @category.status = current_user&.role == "user" ? true : @category.status
      redirect_to categories_path, notice: "Category was successfully updated."
  end

  def destroy
    @category.destroy!
      redirect_to categories_path, notice: "Category was successfully destroyed."
  end

  private

    def authorize_user
      unless current_user&.admin? || current_user&.moderator?
        redirect_to root_url, alert: "You are not authorized to perform this action."
      end
    end

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title, :description, :status)
    end
end
