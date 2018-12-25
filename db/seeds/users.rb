puts 'Start inserting seed "users" ...'

5.times do |n|
  user = User.create({
    name: Faker::Internet.unique.user_name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(8),
    avatar: open("#{Rails.root}/db/picture/avatar/avatar#{n + 1}.jpg")
  })
  puts "\"#{user.name}\" has created!"
end