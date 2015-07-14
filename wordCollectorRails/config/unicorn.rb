# http://www.gotealeaf.com/blog/setting-up-your-production-server-with-nginx-and-unicorn

# set Rails.root
app_path = ENV['PWD']

working_directory app_path

worker_processes 1

listen (app_path + '/tmp/unicorn.sock'), backlog: 64

# listen ('0.0.0.0:3000'), backlog: 64

# timeout 60 # 60 is default value

pid app_path + '/tmp/unicorn.pid'

stderr_path app_path + '/log/unicorn.log'
stdout_path app_path + '/log/unicorn.log'


preload_app true

# Garbage collection settings.
GC.respond_to?(:copy_on_write_friendly=) &&
  GC.copy_on_write_friendly = true

# If using ActiveRecord, disconnect (from the database) before forking.
before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

# After forking, restore your ActiveRecord connection.
after_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
