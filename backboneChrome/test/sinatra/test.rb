require 'sinatra'

post '/upload' do
  puts params

  File.open('./' + params[:picture][:filename], "w") do |f|
    f.write params[:picture][:tempfile].read
  end

  "coming from sinatra - params: #{params}"
end
