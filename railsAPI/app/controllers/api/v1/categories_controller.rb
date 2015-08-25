class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]

  def index
    render json: Category.search(params)
  end

  def show
    render json: Category.find(params[:id])
  end

  def create
    category = current_user.categories.build(category_params)
    if category.save
      render json: category, status: :created
    else
      render json: {errors: category.errors}, status: :unprocessable_entity
    end
  end

  def update
    category = current_user.categories.find_by_id(params[:id])
    if category.blank?
      return head :not_found 
    end
    if category.update(category_params)
      render json: category, status: :ok
    else
      render json: {errors: category.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    category = current_user.categories.find(params[:id])
    category.destroy
    head :no_content
  end

  private
  def category_params
    params.require(:category).permit(:name, :description)
  end
end
