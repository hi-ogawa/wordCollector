# usage
# 
# it {is_expected.to have_http_status 200}
# =>
# it should have http status 200

require 'rspec/expectations'

RSpec::Matchers.define :have_http_status do |code|
  match {|actual| response.status == code}
end


# from https://robots.thoughtbot.com/validating-json-schemas-with-an-rspec-matcher
RSpec::Matchers.define :match_response_schema do |schema|
  match do
    cson_path    = "#{Rails.root}/spec/schemas/controllers/api/v1/#{schema}.coffee"
    json_path    = "#{Rails.root}/spec/schemas/controllers/api/v1/#{schema}.json"
    example_path = "#{Rails.root}/spec/schemas/controllers/api/v1/#{schema}.ex.json"
    `cson2json #{cson_path} > #{json_path}`
    File.open(example_path, "w") do |f|
      f.write JSON.pretty_generate(parse_json(response.body))
    end
    JSON::Validator.validate!(json_path, parse_json(response.body), strict: true)
  end
end
