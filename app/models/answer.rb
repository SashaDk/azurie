class Answer < ActiveRecord::Base
  has_paper_trail
  belongs_to :question
  belongs_to :user
  attr_accessible :text, :fulltext
  validates :text, :presence => true
end
