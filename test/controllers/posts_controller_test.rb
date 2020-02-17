require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:test_post1)
    @user = users(:test_user1)
  end

  test "should get index" do
    get posts_path
    assert_response :success
    assert_select "title", "投稿一覧 | Loca!!y"
  end

  test "should redirect new when not logged in" do
    get newpost_path
    assert_redirected_to login_url
  end

  test "should redirect show when not logged in" do
    get post_path(@post)
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

  test "should redirect destroy for wrong post" do
    log_in_as(users(:test_user1))
    post = posts(:test_post5)
    assert_no_difference 'Post.count' do
      delete post_path(post)
    end
    assert_redirected_to root_url
  end
end
