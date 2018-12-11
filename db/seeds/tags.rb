5.times do
  tag = Tag.create({
    name: Faker::Hacker.noun
  })
  puts "\"#{tag.name}\" has created!"
end