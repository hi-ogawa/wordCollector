require 'spec_helper'

describe Api::V1::UsersController do

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
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
        post :create, {user: @user_attributes}, format: :json
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
    context "when is successfully updated" do
      before(:each) do
        @user = FactoryGirl.create :user
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
        # pp user_response
        expect(user_response).to have_key(:errors)
      end
      it {should respond_with 422}
    end
  end


  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      delete :destroy, {id: @user.id}, format: :json
    end

    it {should respond_with 204}
  end
end
