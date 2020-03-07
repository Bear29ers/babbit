require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "create should require logged-in user" do
    assert_no_difference 'Comment.count' do
      post post_comments_path(comments(:test_comment1))
    end
    assert_redirected_to login_url
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'Comment.count' do
      delete post_comments_path(comments(:test_comment2))
    end
    assert_redirected_to login_url
  end
end
