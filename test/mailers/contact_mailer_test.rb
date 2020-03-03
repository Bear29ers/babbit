require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
  test "contact_mail" do
    contact = contacts(:test_contact1)
    contact.update_attributes(name: "Test Contact1", email: "testcontact1@example.com", content: "This is a test contact 1.")
    mail = ContactMailer.contact_mail(contact)
    assert_equal "お問い合わせ / Babbit", mail.subject
    assert_equal ["y.dream.nest@gmail.com"], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match contact.name, mail.text_part.body.to_s.encode("UTF-8")
    assert_match contact.email, mail.text_part.body.to_s.encode("UTF-8")
    assert_match contact.content, mail.text_part.body.to_s.encode("UTF-8")
  end

end
