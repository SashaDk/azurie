class PagesController < ApplicationController
  def index
    @top_questions = Question.top
    @top_briefings = Briefing.top
  end

  def about
  end
  
  def partners
  end

  def thanks
  end

end
