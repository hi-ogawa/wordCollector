task :default => [:js, :html, :css]

coffees = FileList.new("**/*.coffee")
hamls = FileList.new("**/*.haml")
sass = FileList.new("**/*.sass")

task :js   => coffees.ext(".js")
task :html => hamls.ext(".html")
task :css  => sass.ext(".css")

rule '.js' => '.coffee' do |t|
  sh "coffee -c #{t.source}"
end

rule '.html' => '.haml' do |t|
  sh "haml #{t.source} #{t.name}"
end

rule '.css' => '.sass' do |t|
  sh "sass --sourcemap=none -r compass `compass imports` #{t.source}:#{t.name}"
end
