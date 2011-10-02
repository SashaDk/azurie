class Briefing < ActiveRecord::Base
  CATEGORIES = {
    :business => "Business & Cycles",
    :design => "Design & Creativity",
    :trends => "Trends & Progress"
  }
  has_paper_trail
  belongs_to :user
  attr_accessible :title, :description, :category, :source, :is_quote
  validates :title, :presence => true
  validates :description, :presence => true
end
