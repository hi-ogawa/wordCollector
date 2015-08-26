require "spec_helper"

describe "user update doesn't change auth_token" do

  it do
    user_attr     = FactoryGirl.attributes_for :user
    user_attr2    = FactoryGirl.attributes_for :user

    # create user
    post "api/users", {user: user_attr}

    # login (return auth_token)
    post "api/sessions", {session: {email: user_attr[:email], password: user_attr[:password]}}
    data = JSON.parse(response.body)
    auth_token = data["auth_token"]
    id = data["id"]

    # update user
    put "api/users/#{id}", {user: {email: user_attr2[:email], password: user_attr2[:password]}}, {"Authorization" => auth_token}
    post "api/sessions", {session: {email: user_attr2[:email], password: user_attr2[:password]}}
    auth_token_after = JSON.parse(response.body)["auth_token"]

    # two auth tokens are same
    expect(auth_token).to eql (auth_token_after)
  end
end
