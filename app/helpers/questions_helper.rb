module QuestionsHelper
  def question_category_values
    Question::CATEGORIES.invert
  end
end
