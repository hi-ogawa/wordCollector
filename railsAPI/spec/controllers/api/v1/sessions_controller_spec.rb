require 'spec_helper'

describe API::V1::SessionsController do

  describe "POST #create" do

    before(:each) do
      @user = FactoryGirl.create :user
    end

    context "when request is good" do
      before(:each) do
        post :create, {session: {email: @user.email, password: "12345678"}}, format: :json
      end
      it "returns a user record with new auth_token in a good case" do
        expect(json_response[:auth_token]).to eql @user.auth_token
      end
      it {should respond_with 200}
    end

    context "when request is bad" do
      it "returns a error message in a json object" do
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user_before = FactoryGirl.create(:user)
      delete :destroy, {id: @user_before.auth_token}
    end

    it "changes auth_token to achieve logout feature" do
      @user_after = User.find_by(email: @user_before.email)
      expect(@user_before.auth_token).not_to eql @user_after.auth_token
    end

    it {should respond_with 204}
  end
end
