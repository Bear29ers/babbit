require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:test_post1)
    @user = users(:test_user1)
  end

  test "should redirect new when not logged in" do
    get newpost_path
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: {post: {content: "Lorem ipsum"}}
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end
end
