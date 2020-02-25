require 'test_helper'

class GoodsControllerTest < ActionDispatch::IntegrationTest
  test "create should require logged-in user" do
    assert_no_difference 'Good.count' do
      post post_goods_path(goods(:one))
    end
    assert_redirected_to login_url
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'Good.count' do
      delete post_goods_path(goods(:two))
    end
    assert_redirected_to login_url
  end
end
