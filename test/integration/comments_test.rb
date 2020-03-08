require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user1)
    @post = posts(:test_post7)
    log_in_as(@user)
  end

  test "a user comments on a post and delete it with Ajax" do
    content = "This comment really ties the room together"
    assert_difference '@post.comments.count', 1 do
      post post_comments_path(@post), params: {comment: {content: content}}, xhr: true
    end
    comment = @post.comments.find_by(content: content, user_id: @user.id)
    assert_difference '@post.comments.count', -1 do
      delete post_comment_path(@post, comment), xhr: true
    end
  end
end
