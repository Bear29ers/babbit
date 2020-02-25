require 'test_helper'

class ThumbsupTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user1)
    @post = posts(:test_post4)
    log_in_as(@user)
  end

  # thumbsup page

  # thumbsdown page

  test "should thumbs up a post the standard way" do
    assert_difference '@post.goods.count', 1 do
      post post_goods_path(@post)
    end
    assert_redirected_to root_url
  end
end
