require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Babbit"
    assert_equal full_title("お問い合わせ"), "お問い合わせ | Babbit"
  end
end