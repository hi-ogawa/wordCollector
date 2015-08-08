# usage
# 
# it {is_expected.to have_http_status 200}
# =>
# it should have_http_status 200

require 'rspec/expectations'

RSpec::Matchers.define :have_http_status do |code|
  match do |actual|
    response.status == code
  end
end
