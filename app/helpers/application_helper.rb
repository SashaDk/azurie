module ApplicationHelper
  CATEGORIES = {
    "Enterprising" => [
      ["Idea Validation", :enterprising_idea],
      ["Team", :enterprising_team],
      ["Distribution", :enterprising_distribution],
      ["Marketing and Sales", :enterprising_marketing],
      ["Capital Raising", :enterprising_capital],
      ["Corporate Matters", :enterprising_corporate],
      ["Soft Skills", :enterprising_soft],
    ],
    "Creative" => [
      ["Branding and Storytelling", :creative_branding],
      ["Communication and Presentation", :creative_communication],
      ["Design Matters", :creative_design],
      ["Web design and UX", :creative_web_design]
    ],
    "Progressive" => [
      ["Technology", :progressive_technology],
      ["Market", :progressive_market],
      ["Society and Culture", :progressive_society]
    ]
  }
  
  CATEGORY_GROUPS = {
    :enterprising => "Enterprising",
    :creative => "Creative",
    :progressive => "Progressive"
  }

  def category_values    
    grouped_options_for_select(CATEGORIES)
  end
  
  def category2_name(category)
    Hash[CATEGORIES[category1_name(category)]].invert[category.to_sym] rescue "<unknown>"
  end
  
  def category1_name(category)
    CATEGORY_GROUPS[category.split("_").first.to_sym]
  end
end
