puts 'Start inserting seed "boards" ...'

3.times do |i|
  User.find_each do |user|
    puts "\"#{user.name}\" posted something!"
    user.boards.create({title: Faker::Hacker.noun, body: Faker::Hacker.say_something_smart, user_id: user.id })
  end
end