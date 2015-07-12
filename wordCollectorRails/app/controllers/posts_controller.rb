require 'nokogiri'

class PostsController < ApplicationController
  http_basic_authenticate_with name: "Hiroshi", password: "Ogawa", except: [:index, :iphone, :sort, :change_category, :iphone_word, :iphone_pic]

  skip_before_filter  :verify_authenticity_token
  before_action :set_post, only: [:show, :edit, :update]

  def chrome  # POST /chrome
    p = Post.create(:word        => params[:word],
                    :sentence    => params[:sentence],
                    :category_id => params[:cat_id].to_i,
                    :order       => give_new_order(params[:cat_id].to_i))
    p.picture = params[:picture]
    p.save!
    render :json => {status: "success", data: {from: "posts#chrome"}}
  end


  def iphone_word # GET /iphone_word
    cat_id = Category.where(:name => 'iphone').first
    p = Post.where(:category_id => cat_id).order("created_at").last
    if p.word != ""
      message = "'#{p.word}' is already attachted to"
    else
      p.update(:word => params[:word])
      message = "you attached a word '#{params[:word]}' to"
    end
    builder = Nokogiri::HTML::Builder.new do |doc|
      doc.html { doc.body { doc.span { doc.text message }
                            doc.br
                            doc.img(:src => p.picture.url) }}
    end
    render :text => builder.to_html
  end


  def iphone_pic # POST /iphone_pic
    pic_file = (`ls -t -d #{Rails.root.join('public/iphone/*')} | head -1`).tr("\n","")
    cat_id = Category.where(:name => params[:name]).first.id
    p = Post.create(:word => "",
                    :sentence => "",
                    :category_id => cat_id,
                    :order       => give_new_order(cat_id))
    p.picture = File.open(pic_file)
    p.save!
    render json: {status: "success", data: {from: "posts#iphone_pic"}}
  end

  def sort # POST /sort
    ids = params[:post]
    if ids.length != 0
      [*0..(ids.length - 1)].zip(ids).each do |o, i|
        Post.find(i).update(order: o)
      end
    end
    # json api format comes from http://labs.omniti.com/labs/jsend
    render :json => {status: "success", data: {from: "posts#sort"}}
  end

  def change_category # POST /change_category
    d = params[:dest_id].to_i
    wrap_nil(params[:selected]).each do |s|
      Post.find(s.to_i).update(:category_id => d,
                               :order       => give_new_order(d))
    end
    render :json => {status: "success", data: {from: "posts#change_category"}}
  end


  def multiple_delete # POST /multiple_delete  # this could cause inconsistent order
    wrap_nil(params[:selected]).each do |s|
      Post.find(s.to_i).destroy
    end
    render :json => {status: "success", data: {from: "posts#multiple_delete"}}
  end


  def multiple_edit # POST /multiple_edit
    wrap_nil(params[:edit_w]).each do |p|
      Post.find(p[:id].to_i).update(word: p[:word])
    end
    wrap_nil(params[:edit_s]).each do |p|
      Post.find(p[:id].to_i).update(sentence: p[:sentence])
    end
    render :json => {status: "success", data: {from: "posts#multiple_edit"}}
  end


  ## usual resources ##

  def show # GET /posts/1 (.json)
  end

  def edit # GET /posts/1/edit
    @categories = Category.all.order(:name)
  end
  
  def new  # GET /posts/new
    @post = Post.new
    @category = nil
    @categories = Category.all.order(:name)
  end
  
  def create # POST /posts (.json)
    @post = Post.new(post_params)
    cat_id = params[:cat_id]
    @post.update(:category_id => cat_id,
                 :order       => give_new_order(cat_id))
    @post.picture = params[:post][:picture]
    respond_to do |format|
      if @post.save
        format.html { redirect_to category_url(cat_id) }
        format.json { render json: {status: "success", data: {from: "posts#create"}}}
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update # PATCH/PUT /posts/1 (.json)  # this could cause inconsistent order
    cat_id = params[:cat_id]
    @post.update(post_params)
    @post.update(:category_id => cat_id,
                 :order       => give_new_order(cat_id))
    if params[:post][:picture] != nil
      @post.picture = params[:post][:picture]
    end
    respond_to do |format|
      if @post.save
        format.html { redirect_to category_url(cat_id) }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # parameters are set nil if they are emptry array [], that's why we deal with nil check
    # at the server side, seven hells.
    def wrap_nil(arr)
      arr ? arr : []
    end

    def give_new_order(c_id)
      m = Post.where(:category_id => c_id).map do |p|
        p.order ? p.order : 0
      end
      m.max ? m.max : 0
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      @category = Category.find(@post.category_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:word, :sentence)
    end
end
