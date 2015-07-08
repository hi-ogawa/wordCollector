data = Category.all.map do |c|
  { cat_name: c.name,
    cat_posts: (Post.where(category_id: c.id).map do |p|
                  {w: p.word, s: p.sentence, p: p.picture, c: p.category_id}
                end)
  }
end
File.open('dbdata.yaml', 'w') {|f| f.write(YAML.dump data)}
