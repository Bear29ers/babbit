require 'test_helper'

class ContactsEmailTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "submit invalid contacts information" do
    get contact_path
    assert_select 'form[action="/contact"]'
    post contacts_path, params: {contact: {
                                            name: "",
                                            email: "contact@invalid",
                                            content: ""
                                            }}
    assert_template 'contacts/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors', count: 6
  end

  test "submit valid contacts information" do
    get contact_path
    post contacts_path, params: {contact: {
                                            name: "Example User",
                                            email: "user@example.com",
                                            content: "This is a test contact."
                                            }}
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to root_url
    follow_redirect!
    assert_not flash.empty?
  end
end
