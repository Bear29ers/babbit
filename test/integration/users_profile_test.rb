require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:test_user1)
    @post = posts(:test_post1)
  end

  test "profile display" do
    log_in_as(@user)
    get user_path(@user)
    assert_select 'a[href=?]', edit_user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'img.img-size80'
    assert_match @user.posts.count.to_s, response.body
    assert_select 'ul.pagination'
    assert_match @post.content, response.body
    assert_match @user.active_relationships.count.to_s, response.body
    assert_match @user.passive_relationships.count.to_s, response.body
  end
end
