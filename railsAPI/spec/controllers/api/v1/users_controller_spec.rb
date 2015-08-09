require 'spec_helper'

describe Api::V1::UsersController do


  let(:user)       { FactoryGirl.create :user}
  let(:categories) { 3.times.map {FactoryGirl.create :category, user: user} }

  describe "GET #show" do
    before(:each) do
      get :show, id: user.id
    end
    it {should match_response_schema "users/show"}
    it {should have_http_status 200}
  end

  describe "POST #create" do

    context "params valid" do
      let(:attr)    { FactoryGirl.attributes_for :user }
      before(:each) { post :create, user: attr }
      it {should match_response_schema "users/create"}
      it {should have_http_status 201}
    end

    context "params invalid" do
      let(:invalid_attr) {FactoryGirl.attributes_for :user_wrong_email}
      before(:each)      {post :create, user: invalid_attr}
      it {should match_response_schema "users/create_invalid"}
      it {should have_http_status 422}
    end
  end


  describe "PUT/PATCH #update" do
    before(:each) {header_authorization user.auth_token}

    context "params valid" do
      let(:new_attr)    {FactoryGirl.attributes_for :user}
      before(:each) {put :update, {id: user.id, user: new_attr}}
      it {should match_response_schema "users/update"}
      it {should have_http_status 200}
    end

    context "params invalid" do
      let(:invalid_attr) {FactoryGirl.attributes_for :user_wrong_password}
      before(:each)      {put :update, {id: user.id, user: invalid_attr}}
      it {should match_response_schema "users/update_invalid"}
      it {should have_http_status 422}
    end
  end


  describe "DELETE #destroy" do
    before(:each) {header_authorization user.auth_token}
    before(:each) {delete :destroy, id: user.id}
    it {should have_http_status 204}
  end
end
