class PagesController < ApplicationController
  def index
    @top_questions = Question.top.paginate(:page => params[:page])
  end

  def about
  end
  
  def thanks
  end

end
