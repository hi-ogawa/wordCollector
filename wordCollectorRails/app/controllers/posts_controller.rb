require 'data_uri'

class PostsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  ##### test for making picture from dataurl #######
  def test  # POST /posts/test
    dataurl = params[:picture] # actually, it's already unescaped
    uri = URI::Data.new(dataurl)
    pic_filename = Time.now.strftime("%Y%m%d_%H%M%S.jpg")
    File.open("#{Rails.root}/public/screenshots/#{pic_filename}", 'wb') do |f|
      f.write(uri.data)
    end

    Post.create(:word => params[:word],
                :sentence => params[:sentence],
                :picture => pic_filename,
                :category_id => 5)

    render :text => "you got it uploaded"
  end
  ##################################################

  def iphone  # POST /posts/iphone

    # a pic file is supporsed to come via ssh

    Post.create(:word => params[:word],
                :sentence => params[:sentence],
                :picture => params[:shotname],
                :category_id => 1)

    render :text => "you got it uploaded"
  end

  def upload
    redirect_to :action => 'upload_get'
  end


  def sort
    logger.debug "-------- sort action ---------------"
    ids = params[:post]
    if ids.length != 0
      logger.debug [*0..(ids.length - 1)].zip(ids)
      [*0..(ids.length - 1)].zip(ids).each do |o, i|
        Post.find(i).update(order: o)
      end
    end
    render :text => "no sortable data"
  end


  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(category_id: nil)
    @categories = Category.all
  end

  def change_category
    d = params[:dest_id].to_i
    params[:selected].each do |s|
      Post.find(s.to_i).update(category_id: d)
    end
    redirect_to :action => 'index'
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:word, :sentence, :picture)
    end
end
