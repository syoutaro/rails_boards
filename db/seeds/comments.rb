puts 'Start inserting seed "comments" ...'

3.times do |i|
  User.find_each do |user|
    Board.find_each do |board|
      puts "\"#{board.title}\" posted comment!"
      board.comments.create({comment: Faker::Hacker.say_something_smart, board_id: board.id, user_id: user.id })
    end
  end
end