Post.all.each do |p|
  f = File.open(Rails.root.join('public', 'screenshots', p.picture))
  p.picture_pc = f
  p.save!
  f.close
end
