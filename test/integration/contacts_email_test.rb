require 'test_helper'

class ContactsEmailTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "submit invalid contacts information" do
    get contact_path
    assert_select 'form[action="/contacts"]'
    post contacts_path, params: {contact: {
                                            name: "",
                                            email: "contact@invalid",
                                            content: ""
                                            }}
    assert_template 'contacts/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors', count: 6
  end
end
