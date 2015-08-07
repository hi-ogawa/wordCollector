require 'spec_helper'

describe Api::V1::CategoriesController do

  let(:user)     {FactoryGirl.create :user}
  let(:category) {FactoryGirl.create :category, user: user}

  describe "GET #index" do
    before do
      3.times {FactoryGirl.create :category, user: user}
      get :index
    end
    it {expect(json_response[:categories].length).to eql 3}
  end

  describe "GET #show" do
    before { get :show, id: category.id }
    it { expect(json_response[:category]).to eql symbolized_json(category) }
  end

  describe "POST #create" do
    context "with a proper authentication token" do
      before(:each) {header_authorization user.auth_token}
   
      context "when params are valid" do
        let(:valid_attr) {FactoryGirl.attributes_for :category}
        before(:each) {get :create, {category: valid_attr}}
        it {skip}
      end

      context "when params are invalid" do
        let(:invalid_attr) {FactoryGirl.attributes_for :category_desc_nil}
        before {get :create, {category: invalid_attr}}
        it {skip}
      end
    end

    context "without a proper authentication token" do
      it ""
    end
  end

  describe "PUT/PATCH #update" do
    let(:new_attr) {FactoryGirl.attributes_for :category}
    before(:each) {header_authorization user.auth_token}

    context "with proper existing category id" do
      context "params good" do
        before(:each) {put :update, {id: category.id, category: new_attr}}
        it do 
          expect(response.body).to be_json_eql(new_attr.to_json).at_path("category")
         .excluding("created_at", "updated_at", "id", "user_id")
        end
      end
      context "params bad" do
        it ""
      end
    end
    context "with non-exist category id" do
      before(:each) do
        put :update, {id: 1234, category: new_attr}
      end
      it "" do
        respond_with 404
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do 
      header_authorization user.auth_token
      delete :destroy, id: category.id
    end
    it "" do
      respond_with 204
    end
  end
  
end
