class PagesController < ApplicationController
  def index
    @top_questions = Question.top
  end

  def about
  end
  
  def thanks
  end

end
