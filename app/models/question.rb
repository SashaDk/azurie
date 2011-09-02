class Question < ActiveRecord::Base
  CATEGORIES = {
    :business => "Business & Cycles",
    :design => "Design & Creativity",
    :trends => "Trends & Progress"
  }
  acts_as_paranoid
  acts_as_taggable
  belongs_to :user
  has_many :answers
  attr_accessible :title, :description, :category, :tag_list
  validates :title, :presence => true
  validates :description, :presence => true
  
  def has_answers?
    self.answers.exists?
  end
end
