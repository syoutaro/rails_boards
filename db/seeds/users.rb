puts 'Start inserting seed "users" ...'

5.times do
  user = User.create({
    name: Faker::Internet.unique.user_name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(8),
  })
  puts "\"#{user.name}\" has created!"
end