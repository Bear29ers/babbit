require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:test_user1)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'

    #再設定リンクを送信するメールアドレスが無効の場合
    post password_resets_path, params: {password_reset: {email: ""}}
    assert_not flash.empty?
    assert_template 'password_resets/new'
    #再設定リンクを送信するメールアドレスが有効の場合
    post password_resets_path, params: {password_reset: {email: @user.email}}
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url

    #パスワード再設定フォームのテスト
    user = assigns(:user)
    #パスワード再設定フォームにアクセスしたメールアドレスが無効の場合
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url
    #パスワード再設定フォームに無効なユーザーがアクセスした場合
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    #メールアドレスは有効だが、トークンが無効の場合
    get edit_password_reset_path('wrong token', email: user.email)
    assert_redirected_to root_url
    #メールアドレスとトークンの両方が有効
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email

    #パスワードと確認用パスワードが無効の場合
    patch password_reset_path(user.reset_token), params: {email: user.email,
                                                          user: {password: "foobaz", password_confirmation: "barquux"}}
    assert_select 'div#error_explanation'
    #パスワードが空の場合
    patch password_reset_path(user.reset_token), params: {email: user.email,
                                                          user: {password: "", password_confirmation: ""}}
    assert_select 'div#error_explanation'
    #パスワードと確認用パスワードが有効の場合
    patch password_reset_path(user.reset_token), params: {email: user.email,
                                                          user: {password: "newpassword", password_confirmation: "newpassword"}}
    assert is_logged_in?
    assert_nil user.reload.reset_digest
    assert_not flash.empty?
    assert_redirected_to user
  end

  test "expired token" do
    get new_password_reset_path
    post password_resets_path, params: {password_reset: {email: @user.email}}
    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@user.reset_token), params: {email: @user.email,
                                                          user: {password: "newpassword", password_confirmation: "newpassword"}}
    assert_response :redirect
    follow_redirect!
    assert_match "有効期限が切れています", response.body
  end
end
