class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.petition.subject
  #
  def petition(body,name,email)
    @body= body
    @name= name
    @email= email


    mail to: "minamo.kawano@nifty.com"
  end
end
