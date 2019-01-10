namespace :add_point do
  desc "add point"
  task :user => :environment do
    User.update_all("point = point + 5")
    puts "users add 5 point"
  end
end

