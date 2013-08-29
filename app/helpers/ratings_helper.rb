module RatingsHelper
  def ratings_total(rateable)
    prefix = rateable.class.name.downcase + '_' + rateable.id.to_s
    render :partial => 'ratings/total', :locals => {:rateable => rateable, :prefix => prefix}
  end

  def ratings_info(rateable, args = {})
    prefix = rateable.class.name.downcase + '_' + rateable.id.to_s
    has_rated = false

    if rateable.has_been_rated_by?(current_user)
      case rateable.rating_of(current_user)
      when 1
        rated_how = :up.l.downcase
        rate_icon = 'thumbs-up-alt'
        has_rated = true
      when -1
        rated_how = :down.l.downcase
        rate_icon = 'thumbs-down-alt'
        has_rated = true
      end
    end
    render :partial => 'ratings/info', :locals => {
        :rateable => rateable,
        :rates_name => args[:rates_name],
        :rated_name => args[:rated_name],
        :has_rated => has_rated,
        :rated_how => rated_how,
        :rate_icon => rate_icon,
        :prefix => prefix
    }
  end

  def rating_toggle(rateable)
    prefix = rateable.class.name.downcase + '_' + rateable.id.to_s
    render :partial => 'ratings/toggle', :locals => {:rateable => rateable, :prefix => prefix}
  end

  def rating_vote(rateable, css_class = 'btn')
    render :partial => 'ratings/vote', :locals => {:rateable => rateable, :css_class => css_class}
  end
end