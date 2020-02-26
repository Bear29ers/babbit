require 'test_helper'

class BadTest < ActiveSupport::TestCase
  def setup
    @bad = Bad.new(user_id: users(:test_user1).id, post_id: posts(:test_post4).id)
  end

  test "should be valid" do
    assert @bad.valid?
  end

  test "should require a user id" do
    @bad.user_id = nil
    assert_not @bad.valid?
  end

  test "should require a post id" do
    @bad.post_id = nil
    assert_not @bad.valid?
  end
end
