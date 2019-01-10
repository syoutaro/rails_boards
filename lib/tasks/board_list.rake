require 'date'

namespace :board_list do
  desc 'board list'
  TODAY = Date.today.to_time
  task :board => :environment do
    Board.where("updated_at >= ?", TODAY).find_each do |board|
      puts "=====" * 25
      puts "Title: #{board.title}"
      puts "Content: #{board.body}"
      puts "CommentCount: #{board.comments_count}"
      puts "OwnerName: #{board.owner.name}"
      puts "CreateDay: #{board.created_at.to_s(:task_time)} "
      puts "UpdateDay: #{board.updated_at.to_s(:task_time)}"
    end
  end
end
