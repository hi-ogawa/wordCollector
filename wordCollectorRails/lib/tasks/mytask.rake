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
  sh "rsync #{args[:opt]} . #{args[:dest]} --exclude-from '.rsync_exclude'"
end

desc "export database"
task :export do
  sh "bundle exec rails runner \"eval(File.read 'lib/tasks/export.rb')\""
end
