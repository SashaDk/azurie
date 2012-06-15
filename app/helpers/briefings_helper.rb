module BriefingsHelper
  def briefing_categories
    {
      I18n.t('briefing_categories.popular') => :popular,
      I18n.t('briefing_categories.business') => :business,
      I18n.t('briefing_categories.design') => :design,
      I18n.t('briefing_categories.people') => :people,
      I18n.t('briefing_categories.blogs') => :blogs,
      I18n.t('briefing_categories.video') => :video,
      I18n.t('briefing_categories.weekend') => :weekend,
    }
  end

  def briefing_category_values(selected=nil)    
    options_for_select(briefing_categories, selected)
  end
  
  def briefing_category_name(category)
    briefing_categories.invert[category.to_sym] || "<unknown>"
  end
end
