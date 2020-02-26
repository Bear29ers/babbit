require 'test_helper'

class PostsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user1)
    @post = posts(:test_post1)
    log_in_as(@user)
  end

  test "unsuccessful post edit" do
    get edit_post_path(@post)
    assert_template 'posts/edit'
    patch post_path(@post), params: {post: {content: "", picture: ""}}
    assert_template 'posts/edit'
    assert_select 'div.alert'
  end

  test "successful post edit" do
    get edit_post_path(@post)
    assert_template 'posts/edit'
    content = "Test post edit."
    patch post_path(@post), params: {post: {content: content, picture: ""}}
    assert_not flash.empty?
    assert_redirected_to @post
    @post.reload
    assert_equal content, @post.content
  end
end
