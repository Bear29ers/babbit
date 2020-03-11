require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user1)
    @post = posts(:test_post1)
    @post2 = posts(:test_post5)
  end

  test "post interface" do
    get posts_path
    assert_match "投稿数 (#{Post.count})", response.body
    log_in_as(@user)
    get newpost_path
    assert_select "title", "新規投稿 | Babbit"
    assert_select 'input[type="file"]'
    #無効な新規投稿の場合
    assert_no_difference 'Post.count' do
      post posts_path, params: {post: {content: "", habit: ""}}
    end
    assert_select 'div#error_explanation'
    #有効な新規投稿の場合
    content = "This post really ties the room together"
    picture = fixture_file_upload('test/fixtures/default.jpg', 'image/jpg')
    habit = "This is a new bad habit"
    assert_difference 'Post.count' do
      post posts_path, params: {post: {content: content, picture: picture, habit: habit}}
    end
    assert assigns(:post).picture?
    assert_redirected_to posts_url
    follow_redirect!
    assert_match content, response.body
    assert_match "投稿数 (#{@user.feed.count})", response.body

    #投稿を削除する
    get post_path(@post)
    assert_select 'a', text: "この投稿を編集"
    assert_select 'a', text: "この投稿を削除"
    assert_difference 'Post.count', -1 do
      delete post_path(@post)
    end
    assert_redirected_to posts_url
    follow_redirect!
    assert_select "title", "投稿一覧 | Babbit"

    #違うユーザーのプロフィールにアクセス（削除リンクが表示されていない）
    get post_path(@post2)
    assert_select 'a', text: "この投稿を編集", count: 0
    assert_select 'a', text: "この投稿を削除", count: 0
  end
end
