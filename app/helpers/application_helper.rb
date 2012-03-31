module ApplicationHelper
  CATEGORIES = {
    'Gaining Traction' => :traction,
    'Business Models' => :business_model,
    'People Management' => :people_management,
    'Marketing and Sales' => :marketing,
    'Raising Capital' => :capital_rising,
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
  
  def category_values(selected=nil)    
    options_for_select(CATEGORIES, selected)
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

  JS_ESCAPE_MAP = {
    '\\' => '\\\\',
    '</' => '<\/',
    "\r\n" => '\n',
    "\n" => '\n',
    "\r" => '\n',
    '"' => '\\"',
    "'" => "\\'"
  }

  JS_ESCAPE_MAP["\342\200\250".force_encoding('UTF-8').encode!] = '&#x2028;'
  JS_ESCAPE_MAP["\342\200\251".force_encoding('UTF-8').encode!] = '&#x2029;'
  

  # Escapes carriage returns and single and double quotes for JavaScript segments.
  #
  # Also available through the alias j(). This is particularly helpful in JavaScript responses, like:
  #
  # $('some_element').replaceWith('<%=j render 'some/element_template' %>');
  def my_escape_javascript(javascript)
    if javascript
      result = javascript.gsub(/(\\|<\/|\r\n|\342\200\250|\342\200\251|[\n\r"'])/u) {|match| JS_ESCAPE_MAP[match] }
      javascript.html_safe? ? result.html_safe : result
    else
      ''
    end
  end
end
