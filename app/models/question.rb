class Question < ActiveRecord::Base
  has_paper_trail
  acts_as_taggable
  state_machine :state, :initial => :new do
    event :verify do
      transition :new => :verified
    end
    
    event :unverify do
      transition :verified => :new
    end
  end
  define_index do
    indexes title, :sortable => true
    indexes description
    indexes answers.text, as => :answers_text
    indexes answers.fulltext, as => :answers_fulltext
    indexes tags.name, as => :tags
    indexes user.first_name, as => :user_firstname
    indexes user.last_name, as => :user_lastname
    has :category, :type => :string 
    has answers_count
    where "questions.state = 'verified' and questions.answers_count > 0"
    set_property :delta => false
  end
  belongs_to :user
  has_many :answers, :dependent => :destroy
  has_many :assignments, :dependent => :destroy
  attr_accessible :title, :description, :category, :tag_list, :answers_attributes
  accepts_nested_attributes_for :answers, :reject_if => :all_blank
  validates :title, :presence => true
  validates :user_id, :presence => true
  
  scope :top, :conditions => { :is_top => true }
  scope :verified, :conditions => { :answers_count.gt => 0, :state => :verified }
  scope :recent, :conditions => { :answers_count.gt => 0, :state => :verified }, :limit => 5, :order => :created_at.desc
  scope :popular, :conditions => { :answers_count.gt => 0, :state => :verified }, :limit => 5, :order => :answers_count.desc
  scope :pending, :conditions => { :state => :new }, :order => :created_at.desc
  scope :unanswered, :conditions => { :answers_count => 0, :state => :verified }, :order => :created_at.desc
  scope :all, :order => :created_at.desc

  def has_answers?
    self.answers.exists?
  end
  
  def similar_questions
    Question.joins(:answers)
      .where(:category => self.category, :id.not_eq => self.id)
      .order(:answers => :created_at.desc)
      .limit(5)
      .select('distinct questions.*, answers.created_at')
  end
  
  def self.category(category)
    Question.top.where(:category => category)
  end
end
