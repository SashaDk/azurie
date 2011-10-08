class User < ActiveRecord::Base
  ROLES = [ :guest, :expert, :admin ]

  has_paper_trail
  has_attached_file :avatar, :styles => { :medium => "290x290^" }
  devise :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :confirmable, :token_authenticatable, :invitable
  attr_accessible :email, :first_name, :last_name, 
    :occupation, :location, :company, :contact_email,
    :facebook, :twitter, :google_plus, :linkedin,
    :password, :password_confirmation, :remember_me, :avatar,
    :in_brief
  has_many :questions
  has_many :answers
  has_many :assignments
  has_many :briefings
  
  def display_name
    self.first_name ? "#{self.first_name} #{self.last_name}" : self.email
  end
  
  def answered_questions
    Question.includes(:answers).where(:answers => { :user_id => self.id })
  end
  
  def make_admin!
    self.role = :admin
    self.save
  end
  
  def make_expert!
    self.role = :expert
    self.save
  end
  
  def admin?
    self.role == 'admin'
  end

  def guest?
    self.role == 'guest'
  end
  
  def expert?
    self.role == 'expert'
  end

  def self.find_for_facebook_omniauth(access_token, signed_in_resource=nil)
    data = access_token['user_info']
    user = User.find_by_email(data['email'])
=begin
    unless user # Create a user with a stub password. 
      user = User.new(:email => data['email'], :first_name => data['first_name'],
        :last_name => data['last_name'], :password => Devise.friendly_token[0,20])
      user.skip_confirmation!
      user.save
      user.confirm!
    end
=end
    return user
  end

  def self.find_for_google_apps_open_id(access_token, signed_in_resource=nil)
    data = access_token['user_info']
    user = User.find_by_email(data['email'])
=begin
    unless user # Create a user with a stub password. 
      user = User.new(:email => data['email'], :first_name => data['first_name'], 
        :last_name => data['last_name'], :password => Devise.friendly_token[0,20]) 
      user.skip_confirmation!
      user.save
      user.confirm!
    end
=end
    return user
  end
  
  def self.experts
    User.where(:role => :expert)
  end
end
