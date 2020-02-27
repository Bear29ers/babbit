require 'test_helper'

class ThumbsupTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user1)
    @post = posts(:test_post7)
    log_in_as(@user)
  end

  # thumbsup page

  # thumbsdown page

  test "should thumbs up a post the standard way" do
    assert_difference '@post.goods.count', 1 do
      post post_goods_path(@post)
    end
    # good = @post.goods.find_by(user_id: @user.id, post_id: @post.id)
    # assert_difference '@post.goods.count', -1 do
    #   delete post_goods_path(@post, good)
    # end
  end

  test "should thumbs up a post with Ajax" do
    assert_difference '@post.goods.count', 1 do
      post post_goods_path(@post), xhr: true
    end
    # good = @post.goods.find_by(user_id: @user.id, post_id: @post.id)
    # assert_difference '@post.goods.count', -1 do
    #   delete post_goods_path(@post, good), xhr: true
    # end
  end

  test "should thumbs down a post the standard way" do
    assert_difference '@post.bads.count', 1 do
      post post_bads_path(@post)
    end
    # bad = @post.bads.find_by(user_id: @user.id, post_id: @post.id)
    # assert_difference '@post.bads.count', -1 do
    #   delete post_bads_path(bad)
    # end
  end

  test "should thumbs down a post with Ajax" do
    assert_difference '@post.bads.count', 1 do
      post post_bads_path(@post), xhr: true
    end
    # bad = @post.bads.find_by(user_id: @user.id, post_id: @post.id)
    # assert_difference '@post.bads.count', -1 do
    #   delete post_bads_path(bad), xhr: true
    # end
  end
end
