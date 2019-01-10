namespace :user_list do
  desc "user list"
  task :user => :environment do
    User.find_each do |user|
      puts "=====" * 10
      puts "UserName: #{user.name}"
      puts "BoardCount: #{user.boards_count}"
      puts "UserId: #{user.id}"
      puts "Point: #{user.point}"
      puts "CreateDay: #{user.created_at.to_s(:task_time)} "
      puts "UpdateDay: #{user.updated_at.to_s(:task_time)}"
    end
  end
end
