require 'test_helper'

class BadsControllerTest < ActionDispatch::IntegrationTest
  test "create should require logged-in user" do
    assert_no_difference 'Bad.count' do
      post post_bads_path(bads(:one))
    end
    assert_redirected_to login_url
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'Bad.count' do
      delete post_bads_path(bads(:two))
    end
    assert_redirected_to login_url
  end
end
