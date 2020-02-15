require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user1)
    @post = posts(:test_post1)
    @post2 = posts(:test_post5)
  end

  test "post interface" do
    log_in_as(@user)
    get newpost_path
    assert_select "title", "新規投稿 | Loca!!y"
    #無効な新規投稿の場合
    assert_no_difference 'Post.count' do
      post posts_path, params: {post: {content: ""}}
    end
    assert_select 'div#error_explanation'
    #有効な新規投稿の場合
    content = "This post really ties the room together"
    assert_difference 'Post.count' do
      post posts_path, params: {post: {content: content}}
    end
    assert_redirected_to posts_url
    follow_redirect!
    assert_match content, response.body
    assert_match "投稿数 (#{@user.posts.count})", response.body

    #投稿を削除する
    get post_path(@post)
    assert_select 'a', text: "この投稿を編集"
    assert_select 'a', text: "この投稿を削除"
    assert_difference 'Post.count', -1 do
      delete post_path(@post)
    end
    assert_redirected_to posts_url
    follow_redirect!
    assert_select "title", "投稿一覧 | Loca!!y"

    #違うユーザーのプロフィールにアクセス（削除リンクが表示されていない）
    get post_path(@post2)
    assert_select 'a', text: "この投稿を編集", count: 0
    assert_select 'a', text: "この投稿を削除", count: 0
  end

  # test "post count" do
  #   log_in_as(@user)
  #   get posts_path
  #   assert_match "投稿数 (#{@user.posts.count})", response.body
  #   #まだ投稿していないユーザー
  #   other_user = users(:test_user4)
  #   log_in_as(other_user)
  #   get posts_path
  #   assert_match "投稿数 (0)", response.body
  #   other_user.posts.create!(content: "A post")
  #   get posts_path
  #   assert_match "投稿数 (#{other_user.posts.count})", response.body
  # end
end
