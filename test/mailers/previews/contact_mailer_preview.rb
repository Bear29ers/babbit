# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/contact_mail
  def contact_mail
    contact = Contact.new
    contact.update_attributes(name: "Test Contact1", email: "testcontact1@example.com", content: "This is a test contact 1.")
    ContactMailer.contact_mail(contact)
  end

end
