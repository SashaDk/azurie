class UserMailer < ActionMailer::Base
  default :from => APP_CONFIG[:default_from_email]
  
  def new_answer_notification answer
    @answer = answer
    mail(:to => APP_CONFIG[:default_to_email], :subject => "New answer posted on Azurie")
  end

  def new_question_notification question
    @question = question
    mail(:to => APP_CONFIG[:default_to_email], :subject => "New question posted on Azurie")
  end

  def fakereg(params)
    @params = params
    mail(:to => APP_CONFIG[:default_to_email], :subject => "Yet Another Reg From Azurie")
  end
  
  def assignment(assignment)
    @assignment = assignment
    mail(:to => @assignment.user.email, :subject => "New question on Azurie")
  end

  def invitation_instructions(user)
    @user = user
    @invited_by = user.invited_by
    mail(:to => user.email, :subject => "#{@invited_by.first_name} #{@invited_by.last_name} invited you to join on Azurie")
  end

  def expert_invitation_instructions(user)
    @user = user
    @invited_by = user.invited_by
    mail(:to => user.email, :subject => "#{@invited_by.first_name} #{@invited_by.last_name} invited you to join on Azurie")
  end

  def guest_invitation_instructions(user)
    @user = user
    @invited_by = user.invited_by
    mail(:to => user.email, :subject => "#{@invited_by.first_name} #{@invited_by.last_name} invited you to join on Azurie")
  end
end
