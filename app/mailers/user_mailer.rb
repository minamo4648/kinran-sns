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
  
  def invitation(body,name,email,subject,tanka)
    
    @body = body
    @name = name
    @email = email
    @tanka = tanka

    @dais1 = Dai.where(fase: 1).order(due: :desc).limit(5)
    @dais2 = Dai.where(fase: 2).order(v_due: :desc).limit(5)

    mail to: email, subject: subject

  end
    
end
