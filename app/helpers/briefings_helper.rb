module BriefingsHelper
  def question_category_values
    Briefing::CATEGORIES.invert
  end
end
