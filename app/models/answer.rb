class Answer < ActiveRecord::Base
  has_paper_trail
  acts_as_commentable
  belongs_to :question, :counter_cache => true
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy, :order => :lft, :include => :user
  attr_accessible :text, :fulltext, :book_name, :book_author, :book_link
  validates :text, :presence => true
end
