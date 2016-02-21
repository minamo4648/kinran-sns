class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.petition.subject
  #
  def petition(body)
    @body= body

    mail to: "minamo.kawano@nifty.com"
  end
end
