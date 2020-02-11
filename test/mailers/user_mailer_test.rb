require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:test_user1)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "メールアドレスのご確認 / Loca!!y", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name, mail.text_part.body.to_s.encode("UTF-8")
    assert_match user.activation_token, mail.text_part.body.to_s.encode("UTF-8")
    assert_match CGI.escape(user.email), mail.text_part.body.to_s.encode("UTF-8")
  end

end
