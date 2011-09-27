module ApplicationHelper
  CATEGORIES = {
    "Business & Cycles" => [
      ["Idea Validation", :business_idea],
      ["Business Models", :business_models],
      ["Sales & Marketing", :business_sales],
      ["Negotiation", :business_negotiation],
      ["Ownership & Capital Rising", :business_ownership],
      ["People Management", :business_people],
      ["Money Management", :business_money],
      ["Day To Day Operations", :business_day],
    ],
    "Design & Creativity" => [
      ["Dummy", :design_dummy]
    ],
    "Trends & Progress" => [
      ["Dummy", :trends_dummy]
    ]
  }
  
  CATEGORY_GROUPS = {
    :business => "Business & Cycles",
    :design => "Design & Creativity",
    :trends => "Trends & Progress"
  }

  def category_values    
    grouped_options_for_select(CATEGORIES)
  end
  
  def category2_name(category)
    Hash[CATEGORIES[category1_name(category)]].invert[category.to_sym] #rescue "<unknown>"
  end
  
  def category1_name(category)
    CATEGORY_GROUPS[category.split("_").first.to_sym]
  end
end
