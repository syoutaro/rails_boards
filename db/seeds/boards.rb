puts 'Start inserting seed "boards" ...'

3.times do |n|
  User.find_each do |user|
    puts "\"#{user.name}\" posted something!"
    user.boards.create({title: Faker::Hacker.noun,
      body: Faker::Hacker.say_something_smart,
      image:  open("#{Rails.root}/db/picture/image/image#{n + 1}.jpg"),
      user_id: user.id })
  end
end