require 'spec_helper'

describe Api::V1::CategoriesController do

  let(:user)     {FactoryGirl.create :user}
  let(:category) {FactoryGirl.create :category, user: user}

  describe "GET #index" do
    before do
      3.times {FactoryGirl.create :category, user: user}
      get :index
    end
    it { expect(response.body).to have_json_size(3).at_path "categories" }
  end

  describe "GET #show" do
    before { get :show, id: category.id }
    it { expect(response.body).to be_json_eql(category.to_json)
                                 .at_path("category")
                                 .excluding(:user_id, :user)                          
    }
    it { expect(response.body).to be_json_eql(category.user.to_json)
                                 .at_path("category/user")
    }
  end

  describe "POST #create" do
    let(:valid_attr) {FactoryGirl.attributes_for :category}
    let(:invalid_attr) {FactoryGirl.attributes_for :category_desc_nil}

    context "with a proper authentication token" do
      before(:each) {header_authorization user.auth_token}
      context "with valid params" do
        before(:each) {get :create, {category: valid_attr}}
        it { expect(response.body).to be_json_eql(valid_attr.to_json)
                                     .at_path("category")
                                     .excluding(:id, :created_at, :updated_at, :user)
        }
        it { expect(response.body).to be_json_eql(user.to_json)
                                     .at_path("category/user")
        }
        it { is_expected.to respond_with 201 }
      end

      context "with invalid params" do
        before {get :create, {category: invalid_attr}}
        it { expect(response.body).to be_json_eql(["can't be nil"].to_json)
                                     .at_path("errors/description") 
        }
        it { is_expected.to respond_with 422 }
      end
    end

    context "without a proper authentication token" do
      it { skip "hard to test :("}
    end
  end

  describe "PUT/PATCH #update" do
    let(:valid_attr)     {FactoryGirl.attributes_for :category}
    let(:invalid_attr) {FactoryGirl.attributes_for :category_desc_nil}
    before(:each) {header_authorization user.auth_token}

    context "with proper existing category id" do
      context "with valid params" do
        before(:each) {put :update, {id: category.id, category: valid_attr}}
        it { expect(response.body).to be_json_eql(valid_attr.to_json)
                                     .at_path("category")
                                     .excluding(:id, :created_at, :updated_at, :user)
        }
        it { expect(response.body).to be_json_eql(user.to_json)
                                     .at_path("category/user")
        }
        it { is_expected.to respond_with 200 }
      end
      context "with invalid params" do
        before(:each) { put :update, {id: category.id, category: invalid_attr} }
        it { is_expected.to respond_with 422 }
      end
    end
    context "with non-exist category id" do
      before(:each) { put :update, {id: 1234, category: valid_attr} }
      it { is_expected.to respond_with 404 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do 
      header_authorization user.auth_token
      delete :destroy, id: category.id
    end
    it { is_expected.to respond_with 204 }
  end
  
end
