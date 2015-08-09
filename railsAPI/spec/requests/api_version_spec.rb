require "spec_helper"

describe "API version routing" do

  let(:v1) { {"Accept" => "application/vnd.railsAPI.v1"} }
  let(:v2) { {"Accept" => "application/vnd.railsAPI.v2"} }

  context "without version on header" do
    before(:each) {get "api/items", {}}
    it "routes to version1 by default" do
      should have_http_status 200
    end
  end

  context "with Accept:application/vnd.railsAPI.v1 on header" do
    before(:each) {get "api/items", {}, v1}
    it "routes to version1" do
      should have_http_status 200
    end
  end

  context "with Accept:application/vnd.railsAPI.v2 on header" do
    before(:each) {get "api/items", {}, v2}
    it "routes to version1 no matter what is written on header for now" do
      should have_http_status 200
    end
  end

end
