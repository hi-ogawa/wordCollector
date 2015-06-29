desc "import img files from /Users/hiogawa/Documents/Photos/hiogawa_iphone"
task :import do
  `bundle exec rails runner "eval(File.read 'lib/importPhotos.rb')"`
end
