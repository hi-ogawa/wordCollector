require 'spec_helper'

describe Api::V1::UsersController do

  describe "Routes for Users" do
    let (:req) {{get: "/api/users/1"}}

    describe "defaults: {format: :json}" do
      it "serves json by default" do
        expect(req).to route_to("api/v1/users#show",
                                format: :json,                  
                                id: "1")
      end
    end

    it "doesn't recognize id as a fixnum" do
      expect(req).not_to route_to("api/v1/users#show",
                                   format: :json,                  
                                   id: 1)
    end

    describe "constraints: ApiConstraints.new(version: 1, default: true)" do

      it "serves api version 1 by default" do
        expect(req).to be_routable
      end
      
      it "cannot make sure unavailability of api version 2 on rspec" do
        header_accept_version(2)
        expect(req).to be_routable
      end

    end
  end


  let(:user) {FactoryGirl.create :user}

  describe "GET #show" do
    before(:each) do
      get :show, id: user.id
    end
    it "returns user record in json" do
      expect(json_response[:email]).to eql user.email
    end
    it {should respond_with 200}
  end

  describe "POST #create" do

    context "params valid" do
      let(:attr)    {FactoryGirl.attributes_for :user}
      before(:each) {post :create, user: attr}
      
      it "returns a user record just created" do
        expect(json_response[:email]).to eql attr[:email]
      end
      it {should respond_with 201}
    end

    context "params invalid" do
      let(:invalid_attr) {FactoryGirl.attributes_for :user_wrong_email}
      before(:each)      {post :create, user: invalid_attr}
      it "returns a json error" do
        expect(json_response).to have_key(:errors)
      end
      it {should respond_with 422}
    end
  end


  describe "PUT/PATCH #update" do
    before(:each) {header_authorization user.auth_token}

    context "params valid" do
      let(:new_attr)    {FactoryGirl.attributes_for :user}
      before(:each) {put :update, {id: user.id, user: new_attr}}

      it "returns the updated user record" do
        expect(json_response[:email]).to eql new_attr[:email]
      end
      it {should respond_with 200}
    end

    context "params invalid" do
      let(:invalid_attr) {FactoryGirl.attributes_for :user_wrong_password}
      before(:each)      {put :update, {id: user.id, user: invalid_attr}}
      it "returns a json error" do
        expect(json_response).to have_key(:errors)
      end
      it {should respond_with 422}
    end
  end


  describe "DELETE #destroy" do
    before(:each) {header_authorization user.auth_token}
    before(:each) {delete :destroy, id: user.id}

    it {should respond_with 204}
  end
end
