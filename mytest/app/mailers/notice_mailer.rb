class NoticeMailer < ApplicationMailer
  
  default from: 'minamo.kawano@nifty.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.hello.subject
  #
  def hello
    @greeting = "Hi"

    mail to: "minamo.kawano@nifty.com"
  end
end
