class PostsController < ApplicationController
  http_basic_authenticate_with name: "Hiroshi", password: "Ogawa", except: [:index, :iphone, :sort, :change_category, :iphone2, :iphone3]

  skip_before_filter  :verify_authenticity_token
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def chrome  # POST /chrome
    pic_io = params[:picture]
    pic_filename = Time.now.strftime("%Y%m%d_%H%M%S.jpg")
    File.open(Rails.root.join('public', 'screenshots', pic_filename), 'wb') do |f|
      f.write(pic_io.read)
    end
    Post.create(:word => params[:word],
                :sentence => params[:sentence],
                :picture => pic_filename,
                :category_id => params[:cat_id].to_i)
    render :text => "you got it uploaded\n"
  end

  def iphone_word # GET /iphone_word
    p = Post.where(:name => 'iphone').order("created_at").last
    if p.word != ""
      render :text => "<h1>'#{p.word}' is already attachted to</h2>
                       <img src='/screenshots/#{p.picture}'>"
    else
      p.update(:word => params[:word])
      render :text => "<h1>you attached a word '#{params[:word]}' to</h1>
                       <img src='/screenshots/#{p.picture}'>"
    end
  end

  def iphone_pic # POST /iphone_pic
    cat_id = Category.where(:name => params[:name]).first.id
    pic_io = params[:picture]
    pic_filename = Time.now.strftime("%Y%m%d_%H%M%S.jpg")
    File.open(Rails.root.join('public', 'screenshots', pic_filename), 'wb') do |f|
      f.write(pic_io.read)
    end
    Post.create(:word => "",
                :sentence => "",
                :picture => pic_filename,
                :category_id => cat_id)
    render json: {status: "success", data: {from: "posts#iphone3"}}
  end

  def sort # POST /sort
    logger.debug "--- sort action"
    ids = params[:post]
    if ids.length != 0
      logger.debug [*0..(ids.length - 1)].zip(ids)
      [*0..(ids.length - 1)].zip(ids).each do |o, i|
        Post.find(i).update(order: o)
      end
    end
    # json api format comes from http://labs.omniti.com/labs/jsend
    render :json => {status: "success", data: {from: "posts#sort"}}
  end

  def change_category # POST /change_category
    d = params[:dest_id].to_i
    params[:selected].each do |s|
      Post.find(s.to_i).update(category_id: d)
    end
    render :json => {status: "success", data: {from: "posts#change_category"}}
  end

  def multiple_delete # POST /multiple_delete
    params[:selected].each do |s|
      Post.find(s.to_i).destroy
    end
    render :json => {status: "success", data: {from: "posts#multiple_delete"}}
  end

  def multiple_edit # POST /multiple_edit
    params[:selected].each do |p|
      Post.find(p[:id].to_i).update(word: p[:word])
    end
    render :json => {status: "success", data: {from: "posts#multiple_edit"}}
  end


  ## usual resources ##

  def index # GET /posts (.json)
    @posts = Post.all
    @categories = Category.all
  end

  def show # GET /posts/1 (.json)
  end

  def new  # GET /posts/new
    @post = Post.new
  end
  
  def edit # GET /posts/1/edit
  end
  
  def create # POST /posts (.json)
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

  def update # PATCH/PUT /posts/1 (.json)
    c = @post.category_id
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to category_url(c) }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy # DELETE /posts/1 (.json)
    c = @post.category_id
    @post.destroy
    respond_to do |format|
      format.html { redirect_to category_url(c) }
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
