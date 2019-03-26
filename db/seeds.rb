User.create!(name: "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
10.times do |n|
  name  = FFaker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: false,
               activated: true,
               activated_at: Time.zone.now)
end

10.times do |n|
  Post.create!(title: FFaker::Lorem.sentence(5),
               like_quantity: 0,
               content: FFaker::Lorem.sentence(15),
               sumary: FFaker::Lorem.sentence(5),
               status: 1)
end

10.times do |n|
  10.times do |m|
    Comment.create!(post_id: m+1,
              user_id: n+1,
              content: FFaker::Lorem.sentence(10)
    )
  end
end
