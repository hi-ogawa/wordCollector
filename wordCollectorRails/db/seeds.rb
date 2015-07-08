# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# before "rake db:seed", run "rake export" and place "dbdata.yaml" at the rails root
data = File.open('dbdata.yaml').read
YAML.load(data).each do |c|
  cat = Category.create(name: c[:cat_name])
  c[:cat_posts].each do |ph|
    cat.posts.create(word: ph[:w], sentence: ph[:s], picture: ph[:p], category_id: ph[:c])  
  end
end
