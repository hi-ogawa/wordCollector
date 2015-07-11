##  how to transfer whole rails app
# cd local_rails_root
# rake "rsync[-av, sakura:~/myapps/wordCollectorRails/]"
# ssh sakura
# cd ~/tests/wordCollector/wordCollectorRails; rake export
# cp ~/tests/wordCollector/wordCollectorRails/dbdata.yaml ~/myapps/wordCollectorRails/dbdata.yaml
# cd ~/myapps/wordCollectorRails; bundle install; rake db:setup
# cp -r ~/tests/wordCollector/wordCollectorRails/public/screenshots ~/myapps/wordCollectorRails/public/screenshots
# nohup rails s -p 3005 >/dev/null 2>&1 &


desc "rsync rails project to :dest"
task :rsync, [:opt, :dest] do |t, args|
  args.with_defaults(:opt => '-av', :dest => "sakura:~/myapps/wordCollectorRails/")
  sh "rsync #{args[:opt]} . #{args[:dest]} --exclude-from '.rsync_exclude' --delete-before"
end

desc "run .rb file in rails console"
task :run_rb, [:filename] do |t, args|
  sh "bundle exec rails runner \"eval(File.read 'lib/tasks/#{args[:filename]}')\""
end


desc "run command at remote"
task :ssh_cd_run, [:com, :dir, :host] do |t, args|
  args.with_defaults(host: 'sakura',
                     dir:  '~/myapps/wordCollectorRails/')
  coms_in_ssh = ["source .bash_profile",
                 "cd #{args[:dir]}",
                 args[:com]]
  sh( "ssh #{args[:host]}" + " ' " + coms_in_ssh.join('; ') + " ' " )
end


# http://tesladocet.com/programming/restart-rails-server/
# http://stackoverflow.com/questions/1164091/how-to-stop-a-daemon-server-in-rails
# http://stackoverflow.com/questions/577944/how-to-run-rake-tasks-from-within-rake-tasks
desc "restart daemon server"
task :restart, [:port] do |t, args|
  args.with_defaults(port: '3000')
  Rake::Task['stop'].execute
  Rake::Task['start'].execute(args)
end

desc "stop daemon server"
task :stop do
  sh "kill -9 $(cat tmp/pids/server.pid)"
end

desc "start daemon server"
task :start, [:port] do |t, args|
  args.with_defaults(port: '3000')
  sh "rails s -d -p #{args[:port]}"
end


desc "search daemon server"
task :search, [:key] do |t, args|
  args.with_defaults(key: 'ruby')
  sh "ps aux | grep #{args[:key]}"
end


## examples ##
#
# rake "ssh_cd_run[rake 'restart[3005]']"
# => (local)  ssh sakura ' source .bash_profile; cd ~/myapps/wordCollectorRails/; rake 'restart[3005]' ' 
#    (remote) kill -9 $(cat tmp/pids/server.pid)
#    (remote) rails s -d -p 3005
#
# rake "ssh_cd_run[rake search]" 
# => (local)  ssh sakura ' source .bash_profile; cd ~/myapps/wordCollectorRails/; rake search ' 
#    (remote) ps aux | grep ruby
#
# rake "ssh_cd_run[rake 'run_rb[add_order.rb]']"
# => (local)  ssh sakura ' source .bash_profile; cd ~/myapps/wordCollectorRails/; rake 'run_rb[add_order.rb]' ' 
#    (remote) bundle exec rails runner "eval(File.read 'lib/tasks/add_order.rb')"
