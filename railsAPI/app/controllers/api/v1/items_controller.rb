class Api::V1::ItemsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  before_action :check_category_id, only: [:create, :update]

  def index
    render json: Item.search(params), status: :ok
  end
  
  def show
    item = Item.find_by_id(params[:id])
    if item.present?
      render json: item, status: :ok
    else
      head :not_found
    end
  end 

  def create
    item = current_category.items.build(item_params)
    if item.save
      render json: item, status: :created
    else
      render json: {errors: item.errors}, status: :unprocessable_entity
    end
  end

  def update
    return head :not_found unless item = current_category.items.find_by_id(params[:id])
    if item.update(item_params)
      render json: item, status: :ok
    else
      render json: {errors: item.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    return head :not_found unless item = Item.find_by_id(params[:id])
    item.destroy
    head :no_content
  end

  private

  def item_params
    params.require(:item).permit(:word, :sentence, :meaning, :picture)
  end

  def current_category
    @current_category ||= current_user.categories.find_by_id(params[:category_id])
  end

  def check_category_id
    head :not_found unless current_category.present?
  end
end
