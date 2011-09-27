class UserMailer < ActionMailer::Base
  default :from => APP_CONFIG[:default_from_email]
  
  def fakereg_email(params)
    @params = params
    mail(:to => APP_CONFIG[:default_to_email], :subject => "Yet Another Fake Reg From Azurie")
  end
end
