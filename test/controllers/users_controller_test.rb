require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Loca!!y"
  end

  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", "新規登録 | #{@base_title}"
  end

end
