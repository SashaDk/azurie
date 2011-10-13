class Question < ActiveRecord::Base
  has_paper_trail
  acts_as_taggable
  state_machine :state, :initial => :new
  belongs_to :user
  has_many :answers
  has_many :assignments
  attr_accessible :title, :description, :category, :tag_list
  validates :title, :presence => true
  validates :description, :presence => true
  validates :user_id, :presence => true
  
  def has_answers?
    self.answers.exists?
  end
  
  def similar_questions
    Question.joins(:answers)
      .where(:category => self.category, :id.not_eq => self.id)
      .order(:answers => :created_at.desc)
      .limit(5)
  end
  
  def self.category(category)
    Question.where(:category.like => "#{category}%")
  end
  
  def verified?
    self.state == :verified
  end
  
  def verify!
    self.state = :verified
    self.save
  end
  
  def unverify!
    self.state = :new
    self.save
  end
  
  def self.top
    Question.all
  end
  
  def self.popular
    Question.limit(5)
  end
  
  def self.recent
    Question.limit(5)
  end
end
