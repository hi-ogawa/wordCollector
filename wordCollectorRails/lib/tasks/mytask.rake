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

# e.g. rake "run_rb[add_order.rb]"
desc "run .rb file in rails console"
task :run_rb, [:filename] do |t, args|
  sh "bundle exec rails runner \"eval(File.read 'lib/tasks/#{args[:filename]}')\""
end


# e.g. rake "ssh_cd_run[rake 'run_rb[add_order.rb]', ~/myapps/wordCollectorRails/, sakura]"
desc "run command at remote"
task :ssh_cd_run, [:com, :dir, :host] do |t, args|
  args.with_defaults(host: 'sakura',
                     dir:  '~/myapps/wordCollectorRails/')
  coms_in_ssh = ["source .bash_profile",
                 "cd #{args[:dir]}",
                 args[:com]]
  sh( "ssh #{args[:host]}" + " ' " + coms_in_ssh.join('; ') + " ' " )
end


# http://stackoverflow.com/questions/577944/how-to-run-rake-tasks-from-within-rake-tasks
desc "restart rails server at remote"
task :restart, [:opt, :dest] do |t, args|
  Rake::Task['stop'].execute
  Rake::Task['start'].execute
end


# http://tesladocet.com/programming/restart-rails-server/
# http://stackoverflow.com/questions/1164091/how-to-stop-a-daemon-server-in-rails
desc "start rails server at remote"
task :start, [:port, :host, :dir] do |t, args|
  args.with_defaults(port: '3005',
                     host: 'sakura',
                     dir:  '~/myapps/wordCollectorRails/')
  coms_in_ssh = ["source .bash_profile",
                 "cd #{args[:dir]}",
                 "rails s -d -p #{args[:port]}"]
  sh( "ssh #{args[:host]}" + " ' " + coms_in_ssh.join('; ') + " ' " )
end


desc "stop rails server at remote"
task :stop, [:host, :dir] do |t, args|
  args.with_defaults(host: 'sakura',
                     dir:  '~/myapps/wordCollectorRails/')
  sh "ssh #{args[:host]} ' kill -9 $(cat #{args[:dir]}tmp/pids/server.pid) '"
end


desc "search process at remote"
task :search, [:host, :keyword] do |t, args|
  args.with_defaults(host:    'sakura',
                     keyword: 'ruby')
  sh "ssh #{args[:host]} 'ps aux | grep #{args[:keyword]}'"
end
