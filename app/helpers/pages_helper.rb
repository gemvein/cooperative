module PagesHelper
  def pages_menu_items
    @pages = Page.find_all_root_pages.where(:parent_id => [nil, 0, ''])
    render('pages/menu_items')
  end
end
