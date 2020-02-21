# ユーザー
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

# 投稿
users = User.order(:created_at).take(6)
50.times do
  # content = Faker::Lorem.paragraphs(supplemental: true)
  content = "みなさんは岐阜にはどういった観光スポットがあるかご存知ですか？岐阜は実は美濃地方と飛騨地方に分かれており、観光スポットや温泉、旅館が多くあるのは、飛騨地方です。そのため、岐阜に行こうと思ったときは、 まず飛騨地方で探してください。飛騨地方には高山、下呂温泉、白川郷（世界遺産）といった観光スポットが多くあります。高山は昔ながらの街並みが有名で、「さるぼぼ」という人形がおみやげの定番です。街には温泉、旅館もあり、下呂温泉につぐ温泉街として岐阜では有名です。下呂温泉については日本でも有数な温泉街として有名なので、聞いたことがある方も多いことでしょう。温泉街には昔ながらの旅館も多く、ゆっくりと過ごしたい方にはおすすめです。また白川郷は世界遺産にも登録された、合掌造りの家が並ぶ古い町です。雪国ならではの風景が見たい方にはおすすめです。このように、岐阜県では飛騨地方に多くの観光スポットや旅館があります。岐阜駅から約1～2時間でいけますので、興味のある方は是非ご参考ください。"
  users.each {|user| user.posts.create!(content: content)}
end

# リレーションシップ
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }