i = 0
Category.all.each do |c|
  Post.where(:category_id => c.id).order(:order).each do |p|
    p.order = i
    p.save!
    i += 1
  end
end
