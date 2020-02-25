require 'test_helper'

class GoodTest < ActiveSupport::TestCase
  def setup
    @good = Good.new(user_id: users(:test_user1).id, post_id: posts(:test_post4).id)
  end

  test "should be valid" do
    assert @good.valid?
  end

  test "should require a user id" do
    @good.user_id = nil
    assert_not @good.valid?
  end

  test "should require a post id" do
    @good.post_id = nil
    assert_not @good.valid?
  end
end
