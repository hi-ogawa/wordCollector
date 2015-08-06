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


  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id
    end

    it "returns the information about a reporter on a hash" do
      user_response = json_response
      expect(user_response[:email]).to eql @user.email
    end
    it {should respond_with 200}
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, {user: @user_attributes}
      end
      
      it "returns a user record just created" do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
      end
      it {should respond_with 201}
    end

    context "when is not created" do
      before(:each) do
        @invalid_user_attributes = {email: "JoenDoe@gmail.co",
                                    password: "012345678",
                                    password_confirmation: "1234"}
        post :create, {user: @invalid_user_attributes}, format: :json
      end
      
      it "returns a json error" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end
      it {should respond_with 422}
    end
  end



  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      request.headers["Authorization"] = @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        @new_attributes = {email: "hoge" + @user.email,
                           password: @user.password + "99",
                           password_confirmation: @user.password_confirmation + "99"}
        put :update, {id: @user.id, user: @new_attributes}, format: :json
      end

      it "returns the updated user record" do
        user_response = json_response
        expect(user_response[:email]).to eql @new_attributes[:email]
      end
      it {should respond_with 200}
    end

    context "when is not updated" do
      before(:each) do
        @invalid_user_attributes = {email: "JoenDoeatgmail.co",
                                    password: "012345678",
                                    password_confirmation: "012345678"}
        post :create, {user: @invalid_user_attributes}, format: :json
      end
      
      it "returns a json error" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end
      it {should respond_with 422}
    end
  end


  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      request.headers["Authorization"] = @user.auth_token
      delete :destroy, {id: @user.auth_token}
    end

    it {should respond_with 204}
  end
end
