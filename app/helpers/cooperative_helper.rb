module CooperativeHelper

  def tinymce_init
    render('layouts/tinymce_init')
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

  def actionable_descriptor(actionable, actionable_icon)
    render(:partial => 'layouts/actionable_descriptor', :locals => {:actionable => actionable, :actionable_icon => actionable_icon})
  end

  def tokenize(text)
    text.gsub(/(https?:\/\/[^\s]+\.[a-z\.]{2,6}\/?[^\s\?,;:'"<>]*[^\s\?,;:'"<>\.-])/, '<a href="\1">\1</a>')
      .gsub(/@([^\s\?,;:'"<>]+[^\s\?,;:'"<>\.-])/, '<a href="/people/\1">@\1</a>')
      .gsub(/#([^\s\?,;:'"<>]+[^\s\?,;:'"<>\.-])/, '<a href="/tags/\1">#\1</a>')
      .html_safe
  end

  def video(url, type, args)
    render :partial => 'layouts/video', :locals => {:url => url, :type => type, :width => args[:width], :height => args[:height]}
  end
end
