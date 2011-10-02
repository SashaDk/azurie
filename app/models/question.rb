class Question < ActiveRecord::Base
  has_paper_trail
  acts_as_taggable
  state_machine :state, :initial => :new
  belongs_to :user
  has_many :answers
  attr_accessible :title, :description, :category, :tag_list
  validates :title, :presence => true
  validates :description, :presence => true
  validates :user_id, :presence => true
  
  def has_answers?
    self.answers.exists?
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
