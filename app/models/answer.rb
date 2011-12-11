class Answer < ActiveRecord::Base
  has_paper_trail
  acts_as_commentable
  belongs_to :question, :counter_cache => true
  belongs_to :user
  attr_accessible :text, :fulltext
  validates :text, :presence => true
end
