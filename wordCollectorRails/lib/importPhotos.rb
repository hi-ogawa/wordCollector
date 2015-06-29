# in order to run this script, just put the below line on the shell.
# bash-3.2$ bundle exec rails runner "eval(File.read 'lib/importPhotos.rb')"

require 'pathname'

def h
  Pathname.new("/Users/hiogawa/Documents/Photos/hiogawa_iphone")
end

def p
  Pathname.new("/Users/hiogawa/Dropbox/mydoc/programs/chrome/wordCollector/wordCollectorRails/public/screenshots")
end

def import_to_db

  gap = 0 # avoiding picture name overlap

  h.children.each do |f|
    if f.to_s =~ /\.PNG$/
      # 1. move and rename to /public/screenshots
      pic = (Time.now + gap).strftime("%Y%m%d_%H%M%S.jpg")
      puts "#{f} ==> #{pic}"

      f.rename(p.join(pic))

      # 2. create posts with blank parameters exepts picture attr
      Post.create(:word => "",
                  :sentence => "",
                  :picture => pic,
                  :category_id => 4)

      gap += 1
    end
  end
end

import_to_db
