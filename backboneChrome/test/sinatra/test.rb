require 'sinatra'
require 'json'


get '/chrome_login' do
  # {status: "error"}.to_json
  {status: "success"}.to_json
end


post '/upload' do
  puts params

  File.open('./' + params[:picture][:filename], "w") do |f|
    f.write params[:picture][:tempfile].read
  end

  {status: "success", data: "upload"}.to_json
end



categories = [
              {name: "game of thrones", id: 0},
              {name: "modern family", id: 1},
              {name: "24", id: 2}
             ]

get '/categories' do
  puts params
  puts "categories now: #{categories.to_json}"
  {status: "success", data: categories}.to_json
end


post '/categories' do
  puts params = JSON.parse(request.env["rack.input"].read)
  obj = {
    name: params['name'],
    id: categories.inject(0){|m, h| [m, h[:id]].max} + 1
  }
  puts obj
  categories.push obj
  {status: "success", data: obj}.to_json
end

