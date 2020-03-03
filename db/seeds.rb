# ユーザー
User.create!(
            name: "管理者ユーザー",
            email: "example@railstutorial.org",
            password: "foobar",
            password_confirmation: "foobar",
            admin: true,
            activated: true,
            activated_at: Time.zone.now,
            login_at: Time.zone.now
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
              activated_at: Time.zone.now,
              login_at: rand(1..99).hours.ago
              )
end

# 投稿
users = User.order(:created_at).take(30)
10.times do
  # content = Faker::Lorem.paragraphs(supplemental: true)
  content = "悪い習慣を辞めるためには、まずは、「なぜその習慣を断つ必要があるのか」をできるかぎり明確にしましょう。「本気で改善しないといけない」と自分自身に思い込ませるためです。「なんとなくやめたい」では絶対に続きません。悪い習慣を断とうという挑戦をしていくうえで、「自己否定的な考えは捨てる」ことも重要です。特に自己否定をする傾向にある人は要注意です。「自分は続かない」といった自己否定的な考えが、悪い習慣を断とうという試みを妨害し、元鞘に戻るための言い訳のように作用するのです。"
  users.each {|user| user.posts.create!(content: content)}
end

# リレーションシップ
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# Good、Bad
posts = Post.all
users = User.all
nonadmin = users[49..99]
posts.each do |post|
  nonadmin.each do |user|
    user.goods.create!(post_id: post.id)
    user.bads.create!(post_id: post.id)
  end
end