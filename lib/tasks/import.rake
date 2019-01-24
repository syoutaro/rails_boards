require 'csv'

namespace :import do
  desc "Import useers from csv"

  task users: :environment do
    path = File.join Rails.root, "db/csv/csv_data.csv"
    puts "path: #{path}"
    list = []
    CSV.foreach(path, headers: true) do |user|
      list << {
        name: user["name"],
        email: user["email"],
        password: user["password"]
    }
    end
    puts "start to create users data"
    begin
      User.create!(list)
      puts "completed!!"
    rescue ActiveModel::UnknownAttributeError => invalid
      puts "raised error : unKnown attribute "
    end
  end
end