class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:index, :show]
  skip_before_action  :verify_authenticity_token, only: [:chrome_categories_create,
                                                         :chrome_categories_index]
  before_action :check_user, except: [:chrome_categories_create, :chrome_categories_index]
  before_action :check_chrome, only: [:chrome_categories_create, :chrome_categories_index]

  # access from chrome
  def chrome_categories_create
    @category = Category.new(category_params.merge({user_id: @chrome_user.id}))
    respond_to do |format|
      if @category.save
        format.json { render :show, status: :created, location: @category }
      else
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def chrome_categories_index
    @categories = @chrome_user.categories.all.order(:name)
    respond_to do |format|
      format.json { render :index}
    end
  end

  # GET /categories
  # GET /categories.json
  def index
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @posts = @category.posts.order(:order)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_url }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private

    def check_chrome
      if User.where(email: params[:email]).length == 0
        render :json => {status: "failure", data: {from: "application - check_chrome"}}
      else
        @chrome_user = User.where(email: params[:email]).first
      end
    end

    def set_categories
      @categories = current_user.categories.all.order(:name)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name).merge({user_id: current_user.id})
    end
end
