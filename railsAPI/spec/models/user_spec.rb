require 'spec_helper'

describe User do
  before {@user = FactoryGirl.build(:user)}

  subject {@user}

  it {should respond_to(:email)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should be_valid}

  it {should validate_presence_of(:email)}
  it {should validate_uniqueness_of(:email)}
  it {should validate_confirmation_of(:password)}
  it {should allow_value('example@domain.com').for(:email)}

  it {should respond_to(:auth_token)}
  it {should validate_uniqueness_of(:auth_token)}

  describe "#generate_authentication_token!" do
    it "attach a unique token to a user" do
      Devise.stub(:friendly_token).and_return("mockedtoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "mockedtoken123"
    end

    it "generates another token if one is already taken" do
      Devise.stub(:friendly_token).and_return("mockedtoken123")
      existing_user = FactoryGirl.create(:user)
      Devise.stub(:friendly_token){ Devise.unstub(:friendly_token); "mockedtoken123"}
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end

  describe "has_many :products, dependent: :destroy" do
    let(:user)       {FactoryGirl.create(:user)}
    before           {3.times {FactoryGirl.create :category, user: user}}
    let(:categories) {user.categories}

    it "destroys all associated categories once user is destroyed" do
      user.destroy
      categories.each do |category|
        expect(Category.find(category)).to raise_error "ActiveRecord::RecordNotFound"
      end
    end
  end
end
