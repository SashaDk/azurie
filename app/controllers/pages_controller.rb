class PagesController < ApplicationController
  def index
    @top_questions = Question.top
    @popular_questions = Question.popular
    @recent_questions = Question.recent
  end

  def about
  end

end
