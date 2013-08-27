module CooperativeHelper

  def page_title
    page_title = ""
    if @title
      page_title << @title
      page_title << ': '
    end
    page_title << Cooperative.configuration.application_name
    if @keywords
      page_title << ': '
      page_title << @keywords
    end
    page_title
  end
  
  def container_title
    @title
  end
  
  def flash_class(level)
    case level
      when :notice then "alert-info"
      when :error then "alert-error"
      when :alert then "alert-warning"
    end
  end
  
  def nav_item(text, href, options = {}) 
    html = ""
    html << render(:partial => 'layouts/nav_item', :locals => {:text => text, :href => href, :options => options})
    html.html_safe
  end
  
  def widget(html_options = {}, &block)
    render(:partial => 'layouts/widget', :locals => {:body => capture(&block), :html_options => html_options})
    return ''
  end
  
  def dropdown_nav_item(text, href, active, &block)
    html = ""
    html << render(:partial => 'layouts/dropdown_nav_item', :locals => {:body => capture(&block), :text => text, :href => href, :active => active})
    html.html_safe
  end
  
  def tinymce_init
    html = ""
    html << render('layouts/tinymce_init')
    html.html_safe
  end
  
  def tinymce_options_string
    js_parts = []
    Cooperative.configuration.tinymce_options.each {|key, value| js_parts << "#{key}: #{value.to_json}" }
    js_parts.join(",\n").html_safe
  end
  
  def truncate_words(str, n)
    unless str
      return ''
    end
    strip_tags(str).split(/\s+/, n+1)[0...n].join(' ') + '...'
  end

  def add_tab(label, id, &block)
    active = false
    if @tabs.nil?
      @tabs = []
      active = true
    end
    @tabs << {:id => id, :label => label, :active => active, :content => capture(&block)}
  end

  def render_tabs(orientation = 'top')
    html = ""
    html << render(:partial => 'layouts/tabs', :locals => {:tabs => @tabs, :orientation => orientation})
    @tabs = nil
    html.html_safe
  end

  def badge(content, type)
    html = ""
    html << render(:partial => 'layouts/badge', :locals => {:content => content, :type => type})
    html.html_safe
  end

  def thumbnail(content = '', &block)
    html = ""
    html << render(:partial => 'layouts/thumbnail', :locals => {:content => content ? content : capture(&block)})
    html.html_safe
  end

  def icon(type)
    html = ""
    html << render(:partial => 'layouts/icon', :locals => {:type => type})
    html.html_safe
  end

  def alert(css_class, title, message = nil)
    html = ""
    html << render(:partial => 'layouts/alert', :locals => {:css_class => css_class, :title => title, :message => message})
    html.html_safe
  end

  def actionable_descriptor(actionable, actionable_icon)
    html = ""
    html << render(:partial => 'layouts/actionable_descriptor', :locals => {:actionable => actionable, :actionable_icon => actionable_icon})
    html.html_safe
  end

  def error_messages(object)
    if object.try(:errors) and object.errors.full_messages.any?
      title = I18n.t('bootstrap_forms.errors.header', :model => object.class.model_name.human.downcase)
      message = render(:partial => 'layouts/list', :locals => {:items => object.errors.full_messages.map})
      alert('alert-error', title, message).html_safe
    else
      '' # return empty string
    end
  end

  def tokenize(text)
    text.gsub(/(https?:\/\/[^\s]+\.[a-z\.]{2,6}\/?[^\s]*)/, '<a href="\1">\1</a>')
      .gsub(/@([^\s\?\/,;:'"<>]+)/, '@<a href="/people/\1">\1</a>')
      .gsub(/#([^\s\?\/,;:'"<>]+)/, '#<a href="/tags/\1">\1</a>')
      .html_safe
  end
end
