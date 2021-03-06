require 'spec_helper'

describe Api::V1::ItemsController do

  let(:user)              { FactoryGirl.create :user } 
  let(:category)          { FactoryGirl.create :category, user: user } 
  let(:item)              { FactoryGirl.create :item, category: category } 
  let(:item_attr)         { FactoryGirl.attributes_for :item }

  describe "GET #index" do
    context "without a parameter" do
      before(:each) { 3.times {FactoryGirl.create :item, category: category} }
      before(:each) { get :index }
      it {should match_response_schema "items/index"}
      it { should have_http_status 200 }
    end

    context "with a parameter" do
      let!(:second_user)       { FactoryGirl.create :user }
      let!(:second_categories) { 3.times.map {FactoryGirl.create :category, user: second_user} }
      let!(:second_items) {
        second_categories.map do |c|
          3.times.map {FactoryGirl.create :item, category: c}
        end
      }

      context "with category_id" do
        before(:each) { get :index, {category_id: second_categories[0]} }
        it {should match_response_schema "items/index_with_category_id"}
        it {should have_http_status 200}
      end

      context "with item_ids" do
        before(:each) {get :index, {item_ids: [second_items[0][0], second_items[1][1], second_items[2][2]]}}
        it {should match_response_schema "items/index_with_item_ids"}
        it {should have_http_status 200}
      end
    end
  end
  
  describe "GET #show" do
    context "with existing item id" do
      before(:each) { get :show, {id: item.id} }
      it {should match_response_schema "items/show"}
      it {should have_http_status 200}
    end
    context "with not-existing item id" do
      before(:each) { get :show, {id: 0} }
      it {should have_http_status 404}
    end
  end 

  describe "POST #create" do
    context "with valid auth token" do
      before(:each) { header_authorization user.auth_token }

      context "with existing category_id" do
        context "with valid item params" do
          before(:each) { post :create, {category_id: category.id, item: item_attr} }
          it {should match_response_schema "items/create"}
          it {should have_http_status 201}
        end

        # context "with invalid item params" do; it {skip}; end
      end

      context "with non-existing category_id" do
        before(:each) { post :create, {category_id: 0, item: item_attr} }
        it {should have_http_status 404}
      end

      context "without category_id" do
        before(:each) { post :create, {item: item_attr} }
        it {should have_http_status 404}
      end
    end

    # context "without valid auth token" do; it {skip}; end
  end


  describe "PUT #update" do
    context "with valid auth token" do
      before(:each) { header_authorization user.auth_token }
      context "with existing category_id" do
        context "with valid item params" do
          before(:each) { put :update, {id: item.id, category_id: category.id, item: item_attr} }
          it {should match_response_schema "items/update"}
          it {should have_http_status 200}
        end
        # context "with invalid item params" do; it {skip}; end
      end
      # context "with non-existing category_id" do; it {skip}; end
    end
    # context "without valid auth token" do; it {skip}; end
  end

  describe "DELETE #destroy" do
    context "with valid auth token" do
      before(:each) { header_authorization user.auth_token }
      context "with existing item id" do
        before(:each) { delete :destroy, {id: item.id} }
        it {should have_http_status 204}
      end
      # context "with non-existing item id" do; it {skip}; end
    end    
  end
end
