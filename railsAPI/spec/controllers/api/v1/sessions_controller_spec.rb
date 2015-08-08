require 'spec_helper'

describe Api::V1::SessionsController do

  let(:user)     {FactoryGirl.create :user}
  let!(:category) {FactoryGirl.create :category, user: user}

  describe "POST #create" do
    context "with good params" do
      before(:each) {post :create, {session: {email: user.email, password: user.password}}}
      it {should match_response_schema "sessions/create"}
      it { expect(response.body).to be_json_eql(user.auth_token.to_json)
                                   .at_path "user/auth_token"
      }
      it { is_expected.to respond_with 200 }
    end

    context "with bad params" do
      before(:each) {post :create, {session: {email: user.email, password: ""}}}
      it { is_expected.to respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each)    {delete :destroy, {id: user.auth_token}}
    let(:user_after) {User.find_by(email: user.email)}
    it "changes auth_token to immitate logout" do
      expect(user.auth_token).not_to eql user_after.auth_token
    end

    it { is_expected.to respond_with 204}
  end
end
