#score 10, to: :post_creator, on: 'comments#create' do |comment|
#  comment.title.present?
#end
#
#score 20, on: [
#    'comments#create',
#    'photos#create'
#]
#
#score 15, on: 'reviews#create', to: [:reviewer, :reviewed]

score 10, :to => :user, :on => 'pages#create' do |page|
  page.title.present? and page.body.present?
end

score -10, :to => :user, :on => 'pages#destroy'

score 1, :to => :user, :on => 'statuses#create' do |status|
  status.body.present?
end

score -1, :to => :user, :on => 'statuses#destroy'

score 5, :to => :followed, :on => 'follows#create'

score -5, :to => :followed, :on => 'follows#destroy'