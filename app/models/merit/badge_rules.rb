grant_on 'registrations#create', :badge => 'New User', :model_name => 'User'

grant_on ['registrations#create', 'registrations#update'], :badge => 'Profile Complete', :temporary => true do |user|
  user.bio.present? && user.email.present?
end