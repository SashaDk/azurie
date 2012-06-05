module ApplicationHelper
  def categories
    {
      I18n.t('categories.traction') => :traction,
      I18n.t('categories.business_model') => :business_model,
      I18n.t('categories.people_management') => :people_management,
      I18n.t('categories.marketing') => :marketing,
      I18n.t('categories.capital_rising') => :capital_rising,
      I18n.t('categories.presentation') => :presentation,
      I18n.t('categories.communication') => :communication,
      I18n.t('categories.innovation') => :innovation,
      I18n.t('categories.design') => :design,
      I18n.t('categories.well_being') => :well_being,
      I18n.t('categories.failure') => :failure
    }
  end
  
  def category_values(selected=nil)    
    options_for_select(categories, selected)
  end
  
  def category_name(category)
    categories.invert[category.to_sym] || "<unknown>"
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
