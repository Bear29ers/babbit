class ApplicationMailer < ActionMailer::Base
  default from: '"Babbit" <noreply@example.com>', charset: 'UTF-8'
  layout 'mailer'
end
