require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:test_post1)
    @other_post = posts(:test_post5)
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

  test "should redirect edit when not logged in" do
    get edit_post_path(@post)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch post_path(@post), params: {post: {content: @post.content, picture: ""}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end

  test "should redirect edit for wrong post" do
    log_in_as(@user)
    get edit_post_path(@other_post)
    assert_not flash.empty?
    assert_redirected_to posts_url
  end

  test "should redirect update for wrong post" do
    log_in_as(@user)
    patch post_path(@other_post), params: {post: {content: @other_post.content, picture: ""}}
    assert_not flash.empty?
    assert_redirected_to posts_url
  end

  test "should redirect destroy for wrong post" do
    log_in_as(@user)
    assert_no_difference 'Post.count' do
      delete post_path(@other_post)
    end
    assert_redirected_to posts_url
  end
end
