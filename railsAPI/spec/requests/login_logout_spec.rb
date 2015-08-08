require "spec_helper"

describe "from login to logout via API chain" do

  it "create user > login > create category(success) > logout > create category(error)" do
    user_attr     = FactoryGirl.attributes_for :user
    category_attr = FactoryGirl.attributes_for :category

    # create user
    post "api/users", {user: user_attr}
    expect(response.status).to eql 201


    # login (return auth_token)
    post "api/sessions", {session: {email: user_attr[:email], password: user_attr[:password]}}
    expect(response.status).to eql 200


    # create category
    auth_token = parse_json(response.body)["user"]["auth_token"]
    post "api/categories", {category: category_attr}, {"Authorization" => auth_token}
    expect(response.status).to eql 201

    # logout (have auth_token expired)
    delete "api/sessions/#{auth_token}"
    expect(response.status).to eql 204


    # try to create category (but fails)
    post "api/categories", {category: category_attr}, {"Authorization" => auth_token}
    expect(response.status).to eql 401
  end
end
