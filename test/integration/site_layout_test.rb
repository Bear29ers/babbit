require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user1)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", signup_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", terms_path
    assert_select "a[href=?]", policy_path
    get about_path
    assert_select "title", full_title("Babbitとは")
    get signup_path
    assert_select "title", full_title("新規登録")
  end

  test "layout links when logged in" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user), count: 2
    assert_select "a[href=?]", posts_path
    assert_select "a[href=?]", newpost_path
    assert_select "a[href=?]", logout_path
  end
end
