require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:test_user1)
  end

  test "profile display" do
    log_in_as(@user)
    get user_path(@user)
    assert_select 'a[href=?]', edit_user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'img.gravatar'
    assert_match @user.posts.count.to_s, response.body
    # assert_select 'ul.pagination'
    @user.posts.paginate(page: 1).each do |post|
      assert_match post.content, response.body
    end
  end
end