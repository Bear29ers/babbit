require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Loca!!y"
  end

  test "should get root" do
    get root_url
    assert_response :success
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get static_pages_contact_url
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

  test "should get terms" do
    get static_pages_terms_url
    assert_response :success
    assert_select "title", "Terms of Use | #{@base_title}"
  end

  test "should get policy" do
    get static_pages_policy_url
    assert_response :success
    assert_select "title", "Privacy Policy | #{@base_title}"
  end

end
