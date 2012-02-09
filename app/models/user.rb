class User < ActiveRecord::Base
  ROLES = [ :guest, :expert, :admin ]

  has_paper_trail
  has_attached_file :avatar, :styles => { :medium => "290x290^" },
    :storage => :s3, :bucket => 'azurie-avatars',
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    },
    :default_url => '/images/default_avatar.png'
  devise :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :confirmable, :token_authenticatable, :invitable
  attr_accessible :email, :first_name, :last_name, 
    :occupation, :location, :company, :contact_email,
    :facebook, :twitter, :google_plus, :linkedin,
    :password, :password_confirmation, :remember_me, :avatar,
    :in_brief
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :assignments, :dependent => :destroy
  has_many :assigned_questions, :through => :assignments
  has_many :briefings, :dependent => :destroy
  
  validates :facebook, :format => { :with => /^http(s)?:\/\/(www\.)?facebook\.com\/(.*)/, 
    :message => "should starts with 'http://facebook.com/'" }, :allow_blank => true
  validates :twitter, :format => { :with => /^http(s)?:\/\/?(www\.)?twitter\.com\/(.*)/, 
    :message => "should starts with 'http://twitter.com/'" }, :allow_blank => true
  validates :google_plus, :format => { :with => /^http(s)?:\/\/?plus\.google\.com\/(.*)/, 
    :message => "should starts with 'http://plus.google.com/'" }, :allow_blank => true
  validates :linkedin, :format => { :with => /^http(s)?:\/\/?(.{2,4}\.)?linkedin\.com\/pub\/(.*)|^http(s)?:\/\/?(.{2,4}\.)?linkedin\.com\/profile\/view\/(.*)/, 
    :message => "should starts with 'http://linkedin.com/pub/' or 'http://linkedin.com/profile/view/'" }, :allow_blank => true
    
  def display_name
    self.first_name ? "#{self.first_name} #{self.last_name}" : self.email
  end
  
  def answered_questions
    Question.includes(:answers).where(:answers => { :user_id => self.id })
  end
  
  def pending_questions
    Question.includes(:assignments).where(:assignments => { :user_id => self.id }, :answers_count => 0)
  end
  
  def make_admin!
    self.role = :admin
    self.save
  end
  
  def make_expert!
    self.role = :expert
    self.save
  end
  
  def make_guest!
    self.role = :guest
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

  def has_invitations_left?
    true
  end

  def deliver_invitation
    UserMailer.invitation_instructions(self).deliver
  end 
end
