module BriefingsHelper
  def briefing_categories
    {
      I18n.t('categories.design') => :design,
      I18n.t('categories.energy') => :energy,
      I18n.t('categories.financial') => :financial,
      I18n.t('categories.healthcare') => :healthcare,
      I18n.t('categories.legal') => :legal,
      I18n.t('categories.real_estate') => :real_estate,
      I18n.t('categories.technology') => :technology,
      I18n.t('categories.travel') => :travel,
    }
  end

  def briefing_category_values(selected=nil)    
    options_for_select(briefing_categories, selected)
  end
  
  def briefing_category_name(category)
    briefing_categories.invert[category.to_sym] || "<unknown>"
  end
end
