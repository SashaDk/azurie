class Assignment < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  after_create :notify_user
  
protected
  def notify_user
    UserMailer.assignment(self).deliver
  end
end
