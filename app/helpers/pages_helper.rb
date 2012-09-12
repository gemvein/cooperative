module PagesHelper
  def pages_menu_items
    @pages = Page.where({:public => true, :parent_id => [nil, 0, ''], :pageable_type => [nil, 0, ''], :pageable_id => [nil, 0, '']})
    html = ""
    html << render('pages/menu_items')
    html.html_safe
  end
end
