require 'spec_helper'

describe API::V1::SessionsController do

  let(:user) {FactoryGirl.create :user}

  describe "POST #create" do
    context "with good params" do
      before(:each) {post :create, {session: {email: user.email, password: user.password}}}

      it "returns auth_token" do
        expect(json_response[:user][:auth_token]).to eql user.auth_token
      end
      it {should respond_with 200}
    end

    context "with bad params" do
      it ""
    end
  end

  describe "DELETE #destroy" do
    before(:each)    {delete :destroy, {id: user.auth_token}}
    let(:user_after) {User.find_by(email: user.email)}
    it "changes auth_token to immitate logout" do
      expect(user.auth_token).not_to eql user_after.auth_token
    end

    it {should respond_with 204}
  end
end
