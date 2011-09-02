class Briefing < ActiveRecord::Base
  CATEGORIES = {
    :business => "Business & Cycles",
    :design => "Design & Creativity",
    :trends => "Trends & Progress"
  }
  acts_as_paranoid
  belongs_to :user
  attr_accessible :title, :description, :category, :source, :is_quote
  validates :title, :presence => true
  validates :description, :presence => true
end
