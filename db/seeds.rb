User.create!(
            name: "管理者ユーザー",
            email: "example@railstutorial.org",
            password: "foobar",
            password_confirmation: "foobar",
            admin: true,
            activated: true,
            activated_at: Time.zone.now
            )

99.times do |n|
  name = Faker::Name.name
  email = "exmaple-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
              name: name,
              email: email,
              password: password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now
              )
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.paragraphs(supplemental: true)
  users.each {|user| user.posts.create!(content: content.join(''))}
end