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
end
