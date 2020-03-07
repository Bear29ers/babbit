require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = Comment.new(content: "Lorem ipsum", post_id: posts(:test_post4).id, user_id: users(:test_user1).id)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "should require comments" do
    @comment.content = nil
    assert_not @comment.valid?
  end
end
