module ApplicationHelper
  CATEGORIES = {
    'Gaining Traction' => :traction,
    'Business Models' => :business_model,
    'People Management' => :people_management,
    'Marketing and Sales' => :marketing,
    'Raising capital' => :capital_rising,
    'Mastering Presentation' => :presentation,
    'Mastering Media' => :communication,
    'New Frontiers' => :innovation,
    'Product Design' => :design,
    'Work-Life Balance' => :well_being,
    'Failure' => :failure
  }
  
  def categories
    CATEGORIES
  end
  
  def category_values    
    options_for_select(CATEGORIES)
  end
  
  def category_name(category)
    CATEGORIES.invert[category.to_sym] || "<unknown>"
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
