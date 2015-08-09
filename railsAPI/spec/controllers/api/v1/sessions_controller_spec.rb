require 'spec_helper'

describe Api::V1::SessionsController do

  let(:user)     {FactoryGirl.create :user}
  let(:category) {FactoryGirl.create :category, user: user}

  describe "POST #create" do
    context "with valid params" do
      before(:each) {post :create, {user: {email: user.email, password: user.password}}}
      it {should match_response_schema "sessions/create"}
      it {should have_http_status 200}
    end

    context "with invalid params" do
      before(:each) {post :create, {user: {email: user.email, password: ""}}}
      it {should have_http_status 422}
    end
  end

  describe "DELETE #destroy" do
    before(:each)    {delete :destroy, {id: user.auth_token}}
    let(:user_after) {User.find_by(email: user.email)}
    it "changes auth_token to immitate logout" do
      expect(user.auth_token).not_to eql user_after.auth_token
    end

    it {should have_http_status 204}
  end
end
