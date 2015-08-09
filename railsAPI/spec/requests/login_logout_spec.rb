require "spec_helper"

describe "from login to logout via API chain" do

  it "create user > login > create category(success) > logout > create category(error)" do
    user_attr     = FactoryGirl.attributes_for :user
    category_attr = FactoryGirl.attributes_for :category

    # create user
    post "api/users", {user: user_attr}
    should have_http_status 201


    # login (return auth_token)
    post "api/sessions", {session: {email: user_attr[:email], password: user_attr[:password]}}
    should have_http_status 200


    # create category
    auth_token = JSON.parse(response.body)["user"]["auth_token"]
    post "api/categories", {category: category_attr}, {"Authorization" => auth_token}
    should have_http_status 201


    # logout (have auth_token expired)
    delete "api/sessions/#{auth_token}"
    should have_http_status 204


    # try to create category (but fails)
    post "api/categories", {category: category_attr}, {"Authorization" => auth_token}
    should have_http_status 401

  end
end
