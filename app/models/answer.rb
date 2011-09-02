class Answer < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :question
  belongs_to :user
  attr_accessible :text
  validates :text, :presence => true
end
