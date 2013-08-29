prefix = '<%= @rateable.class.name.downcase %>_<%= @rateable.id.to_s %>'

$('.' + prefix + '_ratings_average').html('<%= @rateable.person_ratings.average(:weight) %>');
$('.' + prefix + '_ratings_total').html('<%= @rateable.person_ratings.sum(:weight) %>');
$('.' + prefix + '_ratings_count').html('<%= @rateable.person_ratings.count %>');
$('#' + prefix + '_vote_large_primary').html('<%= escape_javascript(render :partial => 'vote', :locals => {:rateable => @rateable, :css_class => 'btn btn-primary btn-large'}) %>');
$('#' + prefix + '_ratings_info').html('<%= escape_javascript(ratings_info @rateable, :rates_name => :votes.l.downcase, :rated_name => :voted.l.downcase) %>');
$('#' + prefix + '_ratings_toggle').replaceWith('<%= escape_javascript(rating_toggle @rateable) %>')