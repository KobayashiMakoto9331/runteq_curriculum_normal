20.times do |n|
  title = Faker::Color.color_name
  body = Faker::Beer.malts
  user = User.find(rand(15..20))
  Board.create!(title: title,
                body: body,
                user: user)
end