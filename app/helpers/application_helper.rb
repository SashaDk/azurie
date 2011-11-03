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
  
  def categories
    CATEGORIES
  end
  
  def category_groups
    CATEGORY_GROUPS
  end

  def category_values    
    grouped_options_for_select(CATEGORIES)
  end
  
  def category_name(category)
    category2_name(category).blank? ? category1_name(category) : category2_name(category)
  end
  
  def category2_name(category)
    Hash[CATEGORIES[category1_name(category)]].invert[category.to_sym] rescue "<unknown>"
  end
  
  def category1_name(category)
    CATEGORY_GROUPS[category.split("_").first.to_sym]
  end
  
  def pluralize_without_number(number, string)
    pluralize(number, string)[/(\d)+ (.*)/, 2]
  end
  
  def current_user?(user)
    user_signed_in? && current_user == user
  end
  
  def flash_helper
    f_names = [:notice, :warning, :message]
    fl = ''
    for name in f_names
      if flash[name]
        fl = fl + "<div class=\"notice\">#{flash[name]}</div>"
      end
      flash[name] = nil;
    end
    fl.html_safe
  end

  def title(title)
    content_for(:title) { " | #{title}" }
  end
end
