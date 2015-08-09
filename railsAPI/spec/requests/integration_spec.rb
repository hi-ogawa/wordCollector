require "spec_helper"

describe "-- integration API chain --" do

  it do
    user_attr     = FactoryGirl.attributes_for :user
    category_attr = FactoryGirl.attributes_for :category
    item_attr     = FactoryGirl.attributes_for :item

    puts "create user"
    post "api/users", {user: user_attr}
    should have_http_status 201


    puts "login (return auth_token)"
    post "api/sessions", {session: {email: user_attr[:email], password: user_attr[:password]}}
    should have_http_status 200


    puts "create category"
    auth_token = JSON.parse(response.body)["user"]["auth_token"]
    post "api/categories", {category: category_attr}, {"Authorization" => auth_token}
    should have_http_status 201

    puts "create item"
    category_id = JSON.parse(response.body)["category"]["id"]
    post "api/items", {category_id: category_id, item: item_attr}, {"Authorization" => auth_token}
    should have_http_status 201

    puts "logout (have auth_token expired)"
    delete "api/sessions/#{auth_token}"
    should have_http_status 204


    puts "try to create category (but fails)"
    post "api/categories", {category: category_attr}, {"Authorization" => auth_token}
    should have_http_status 401

  end
end
