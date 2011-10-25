class UserMailer < ActionMailer::Base
  default :from => APP_CONFIG[:default_from_email]
  
  def fakereg(params)
    @params = params
    mail(:to => APP_CONFIG[:default_to_email], :subject => "Yet Another Reg From Azurie")
  end
  
  def assignment(assignment)
    @assignment = assignment
    mail(:to => @assignment.user.email, :subject => "New question on Azurie")
  end
end
