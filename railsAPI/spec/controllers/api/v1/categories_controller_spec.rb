require 'spec_helper'

describe Api::V1::CategoriesController do

  let!(:user)     { FactoryGirl.create :user }
  let!(:category) { FactoryGirl.create :category, user: user }
  let!(:items)    { 3.times.map {FactoryGirl.create :item, category: category} }

  describe "GET #index" do
    context "without parameter" do
      let!(:categories) { 3.times.map {FactoryGirl.create :category, user: user} }
      before(:each) {get :index}
      it {should match_response_schema "categories/index"}
      it {should have_http_status 200}
    end

    context "with user_id parameter" do
      let!(:second_user)       { FactoryGirl.create :user, username: "testtest"}
      let!(:second_categories) { 3.times.map {FactoryGirl.create :category, user: second_user}}
      before { get :index, {user_id: second_user.id} }
      it { should match_response_schema "categories/index_with_user_id" }
      it { should have_http_status 200 }
    end

    context "with category_ids parameter" do
      let!(:categories) { 3.times.map {FactoryGirl.create :category, user: user}}
      before { get :index, {category_ids: [category.id]} }
      it { should match_response_schema "categories/index_with_category_ids" }
      it { should have_http_status 200 }
    end
  end

  describe "GET #show" do
    before { get :show, id: category.id }
    it {should match_response_schema "categories/show"}
    it {should have_http_status 200}
  end

  describe "POST #create" do
    let(:valid_attr) {FactoryGirl.attributes_for :category}
    let(:invalid_attr) {FactoryGirl.attributes_for :category_desc_nil}

    context "with a proper authentication token" do
      before(:each) {header_authorization user.auth_token}
      context "with valid params" do
        before(:each) {post :create, {category: valid_attr}}
        it {should match_response_schema "categories/create"}
        it {should have_http_status 201}
      end

      context "with invalid params" do
        before {post :create, {category: invalid_attr}}
        it {should have_http_status 422}
      end
    end

    context "without a proper authentication token" do
      before(:each) {post :create, {category: valid_attr}}
      it {should have_http_status 401}
    end
  end

  describe "PUT/PATCH #update" do
    let(:valid_attr)     {FactoryGirl.attributes_for :category}
    let(:invalid_attr) {FactoryGirl.attributes_for :category_desc_nil}
    before(:each) {header_authorization user.auth_token}

    context "with proper existing category id" do
      context "with valid params" do
        before(:each) {put :update, {id: category.id, category: valid_attr}}
        it {should match_response_schema "categories/update"}
        it {should have_http_status 200}
      end
      context "with invalid params" do
        before(:each) { put :update, {id: category.id, category: invalid_attr} }
        it {should have_http_status 422}
      end
    end
    context "with non-exist category id" do
      before(:each) { put :update, {id: 1234, category: valid_attr} }
      it {should have_http_status 404}
    end
  end

  describe "DELETE #destroy" do
    before(:each) do 
      header_authorization user.auth_token
      delete :destroy, id: category.id
    end
    it {should have_http_status 204}
  end
  
end
