require 'spec_helper'

describe "Authrization Header" do
  let(:user)            { FactoryGirl.create :user }
  let(:category_attr)   { FactoryGirl.attributes_for :category }
  let(:headers)         { {"Authorization" => user.auth_token} }

  describe "post /api/categories" do

    context "with a proper authentication header" do
      before(:each) { post "api/categories", {category: category_attr}, headers }
      # it { pp response }
      it { expect(response.status).to eql 201 }
    end

    context "without a proper authentication header" do
      before(:each) { post "api/categories", {category: category_attr} }
      # it { pp response }
      it { expect(response.status).to eql 401 }
    end
  end

  describe "put /api/users/:id" do
    
    let(:user_attr) {FactoryGirl.attributes_for :user}

    context "with a proper authentication header" do
      before(:each) { put "api/users/#{user.id}", {user: user_attr}, headers }
      # it { pp response }
      it { expect(response.status).to eql 200 }
    end

    context "without a proper authentication header" do
      before(:each) { put "api/users/#{user.id}", {user: user_attr} }
      # it { pp response }
      it { expect(response.status).to eql 401 }
    end
  end
end
